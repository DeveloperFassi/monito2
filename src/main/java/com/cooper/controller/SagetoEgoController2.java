package com.cooper.controller;


import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.cooper.daoracle.FICXINTRepository;
 import com.cooper.entities.FICXINT;
 

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;


@Controller
public class SagetoEgoController2 {

	@Autowired
	FICXINTRepository fICXINTRepository;
 	
	@RequestMapping(value = "/")
	public String home() {
		return ("redirect:/sagetoego");
	}
		@RequestMapping(value = "/sagetoego",method = RequestMethod.GET)
		public String OutWMS(Model model, 
							@RequestParam(defaultValue = "0", name = "page") int page,
							@RequestParam(defaultValue = "100", name = "size") int size) {
						 
		 	//select top1000 au chargement de la page 
			Page<FICXINT> ListFICXINTErreur = fICXINTRepository.findAllDistinctByFLAXFIC(PageRequest.of(page, size), "E"); 
		 	model.addAttribute("ListFICXINTErreur", ListFICXINTErreur);
			
			int NbrFICXINTErreur = fICXINTRepository.NbrFICXINTErreur();
			model.addAttribute("NbrFICXINTErreur", NbrFICXINTErreur);			

			//charger combobox interface 
			List<String> ListInterface = fICXINTRepository.ListInterface();
			model.addAttribute("ListInterface", ListInterface);
			
			
			return "sagetoego";
		}
		

		//date oracle par interface
		@RequestMapping(value = "/ListDateOracle/{interfac}",method = RequestMethod.GET)
		public @ResponseBody TreeSet<String> ListDateOracle(Model model,@PathVariable("interfac") String interfac)  
		{
			ArrayList<Date> ListDateCreation = (ArrayList<Date>) fICXINTRepository.ListDateOracle(interfac); 
			HashSet<String> ListuniqueDateValues = new HashSet<>();	
			SimpleDateFormat mydateFormat = new SimpleDateFormat("yyyy-MM-dd");
			TreeSet<String> ts = (TreeSet<String>) new TreeSet<String>().descendingSet();
			for(int i=0; i<ListDateCreation.size(); i++){		
				String dateCreation=mydateFormat.format(ListDateCreation.get(i));
				ListuniqueDateValues.add(dateCreation);
				ts.add(dateCreation);
			}		 
			model.addAttribute("ListDateOracle", ListuniqueDateValues);
			return ts;
		}
	 
		//charger tableau non oracle filtrer par interface et date
		@RequestMapping(value = "/ListFICXINTErreurFiltrer/{interfac}/{date2}",method = RequestMethod.GET)
		public @ResponseBody List<FICXINT> ListFICXINTErreurFiltrer(Model model,@PathVariable("interfac") String interfac,@PathVariable("date2") String date2) throws ParseException 
		{
			List<FICXINT> ListFICXINTErreurFiltrer = fICXINTRepository.ListFICXINTErreurFiltrer(interfac,date2);
			model.addAttribute("ListFICXINTErreurFiltrer", ListFICXINTErreurFiltrer);	
			return ListFICXINTErreurFiltrer;		
		}
		

		
		
		
		@RequestMapping(value = "/data")
		public ResponseEntity<Map<String, Object>> data(
				@RequestParam(name = "draw", defaultValue = "0") int p,
				@RequestParam(name = "size", defaultValue = "10") int s, 
				@RequestParam(name = "start", defaultValue = "0") int st) 
			{
			  int page = st/s;
			  Pageable firstPage = PageRequest.of(page, s); 	
			  //Page<FICXINT> ListFICXINTErreur = fICXINTRepository.findAll(firstPage);	
			  Page<FICXINT> ListFICXINTErreur = fICXINTRepository.ListFICXINTErreurPage(firstPage);			  
			 // Page<FICXINT> ListFICXINTErreur = fICXINTRepository.findDistinctByFLAXFIC(firstPage,"E");
			  Map<String, Object> response = new HashMap<>();
		      response.put("data", ListFICXINTErreur.getContent());
		      response.put("draw", p);
		      response.put("start", st);
		      response.put("recordsTotal", ListFICXINTErreur.getTotalElements());
		      response.put("recordsFiltered", ListFICXINTErreur.getTotalElements());
		      response.put("totalPages", ListFICXINTErreur.getTotalPages());

		      return new ResponseEntity<>(response, HttpStatus.OK);
			 
		}
		
		
		
		
		
	
		///////////////////////////////////////////donwload fichier txt//////////////////////////////////////////////////////////////
		
		//version2 download fichier txt
		@Value("file:C:\\WMS-EN-TEST\\EgoInterfaceFiles\\SAGETOWMS\\")
		//@Value("file://///WMS-EN-TEST/EgoInterfaceFiles/SAGETOWMS")
		Resource directory ;	
		@RequestMapping(value = "/sagetoego/filetxt/{nomfichier}/{typefichier}",method = RequestMethod.GET)
		public @ResponseBody String downloadtxt(Model model,@PathVariable("nomfichier") String nomfichier,@PathVariable("typefichier") String typefichier) throws IOException   
		{
			File file= directory.getFile();	
			Assert.state(file.isDirectory());			
			//Path path = Paths.get(file+"\\"+typefichier+"\\"+typefichier+"Historique");		
			String chemin=file+"\\"+typefichier+"\\"+typefichier+"Historique\\"+nomfichier;
			System.out.println(chemin);
			BufferedReader br = new BufferedReader(new FileReader(chemin));
			String contenufile="";
			try {
			    StringBuilder sb = new StringBuilder();
			    String line = br.readLine();

			    while (line != null) {
			        sb.append(line);
			        sb.append(System.lineSeparator());
			        line = br.readLine();
			    }
			    contenufile = sb.toString();
			   // System.out.println(contenufile);
			} finally {
			    br.close();
			}
			
			return contenufile;
			
	
		}
		
		
		//version2 download fichier sage
		@RequestMapping(value = "/sagetoego/idFichierWms1/{idFichierWms}",method = RequestMethod.GET)
		public @ResponseBody String FichierSageContenu(Model model,@PathVariable("idFichierWms") int idFichierWms) throws IOException   
		{
			FICXINT fichier =fICXINTRepository.findByIdFichierWMS(idFichierWms);
			String myvar=fichier.getLIGXFIC();
			String status="";
			status = myvar;		 
			model.addAttribute("status", status);
			System.out.println(status);
			return status;
		}
}
