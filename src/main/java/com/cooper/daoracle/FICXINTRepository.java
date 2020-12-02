package com.cooper.daoracle;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.cooper.entities.FICXINT;
 
@Repository
public interface FICXINTRepository extends JpaRepository<FICXINT, Long>{
	 
	 
	//select top1000 au chargement de la page
	
	@Query(value = "select distinct e from FICXINT e where e.FLAXFIC ='E' ")
	Page<FICXINT> ListFICXINTErreurTop(Pageable pageable);
	
	Page<FICXINT> findAllDistinctByFLAXFIC(Pageable pageable, @Param(value = "E") String str);
	
	//query interface
	@Query("select distinct e.INTXFIC from FICXINT e where e.FLAXFIC ='E' order by e.INTXFIC")
	public List<String> ListInterface();
	
	
	//query date par interface
	@Query("select distinct e.DATXFIC from FICXINT e where e.FLAXFIC ='E' and e.INTXFIC = :x order by e.DATXFIC")
	public List<Date> ListDateOracle(@Param("x")String INTXFIC);
	
	//query charger tableau filtrer par interface et date
	@Query(value = "select distinct e from FICXINT e where e.FLAXFIC ='E' and INTXFIC=:x and Convert(date, DATXFIC) =:date")
	List<FICXINT> ListFICXINTErreurFiltrer(String x,String date);

	
	@Query("select distinct e from FICXINT e where e.FLAXFIC ='E' ")
	public List<FICXINT> ListFICXINTErreur();
	
	@Query("select distinct e from FICXINT e where e.FLAXFIC ='E' ")
	public Page<FICXINT> ListFICXINTErreurPage(Pageable pageable);
	 
	@Query("select count(e.FLAXFIC) from FICXINT e where e.FLAXFIC = 'E'")
	public int NbrFICXINTErreur();
	 
	@Query("select distinct e from FICXINT e where NLIXFIC = :x and DATXFIC = :y")
	public FICXINT findByIdFichierWMS(@Param("x")int idFichierWms);
		
}
