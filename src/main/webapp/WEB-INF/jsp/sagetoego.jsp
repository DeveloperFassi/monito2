
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags"%>

<mt:simpletemplate title="Sage to EGO">

	<jsp:attribute name="content"> 

		<div class="container" style="width: 95%">
			
			<div class="panel panel-primary">				
 
				<div class="panel-heading">
					<b>SAGE TO EGO :</b>
				</div>	 
				<div class="panel-body">
					
						<!-- Tab-Pan -->
						<ul class="nav nav-tabs">
						    <li id="m1" class="active"><a data-toggle="tab"
							href="#menu1">Erreur depuis EGO: ${ NbrFICXINTErreur }</a></li>
							
						</ul>
						
						<div class="tab-content">						
							      
							  
						    <!-- =====================Onglet Erreur depuis EGO============================ -->
						    <div id="menu1" class="tab-pane fade in active">							    
							 	 
							   <div class="form-check">
								    <input type="checkbox" class="form-check-input"		id="checkboxnon" style="margin-left: 15px;"	onclick="CheckedClick1(this);">
								    <label class="form-check-label" for="checkboxnon">Filtrer par :</label>
							    </div>
							    <div style="text-align: left; display: none;" id="divdatenon">
								    <div class="row" style="margin-left: 0px;">
								   		 <div class="col-md-3">
									    	<label for="cbxInterface" id="LblInterface"	style="margin-left: 20px;">Interface : </label>
											<select id="cbxInterface" class="form-control"	style="margin-top: -2px;"	onchange="chargerDateInterface(this);"> 
											  <option value="=== Sélectionner ===" disabled selected>=== Sélectionner ===</option>
											  <c:forEach items="${ ListInterface }" var="p">
											  	<option value="${ p }">${ p }</option> 
											  </c:forEach>											   
											</select>
								    	</div>
								    	<div class="col-md-3" id="divfiltre1"
										style="display: none;">
									    	<label for="cbxdatenon" id="Lbldatenon"
											style="margin-left: 20px;">Date import : </label>
											<select id="cbxdatenon" class="form-control"
											style="margin-top: -2px;" onchange="chargerTableauOracle();"> 
<!-- 											  <option value="1">value1</option>         -->
											</select>
											
											<div id="viewDiv">
												<img id="loading" src="${contextPath}/images/54397.gif"
												style="display: block; margin-left: 110%; margin-top: -32px; width: 110px; display: none;" />
											</div>

								    	</div>
								    	
								    </div>									
								</div>        							     			
									<div class="col-md-12" style="overflow: auto;" id="divSage">

										<table class="table table-bordered table-striped"
									id="tableSageFichier">
											<thead>
												<tr class="header">												
													
													<th>Status</th>	
													<th>Interface</th>	
													<th style="width: 400px;">Nom Fichier</th>									
													<th>Code</th>																										
													<th>Date import</th>																				
													<th>Ligne fichier</th>
												</tr>
											</thead>
											
											<tbody> 
												<c:forEach items="${ ListFICXINTErreur.getContent() }"	var="p">
												    <tr>												   		 
													
														<td>${p.FLAXFIC }</td>	
														<td>${p.INTXFIC }</td>													
											       		<td>
												        	<a href="#" id="a2" hidden="">test</a>
															<a id="aa2"		onclick="downloadTxt('${p.NOMXFIC}','${p.INTXFIC}')"													style="cursor: pointer;">
															<span class="glyphicon glyphicon-download"			title="Télécharger"> ${p.NOMXFIC}</span>
															</a>																				 
											       		 </td>
														<td>${p.DEPXFIC }</td>														
														<td>${p.DATXFIC }</td>													
														
														<td>
				 								        	<a href="#" id="a11" hidden="">test</a> 
															<a id="aa11" onclick="getWmsTxtOui('${p.LIGXFIC }')"
													style="cursor: pointer;">
															<span class="glyphicon glyphicon-download"
														title="Télécharger"> </span> 
															</a> 
															<button onclick="myFunctionReadmore(this)" id="myBtn"
														style="background: none !important; border: none; padding: 0 !important; color: #069; font-size: 13px;">Afficher...</button>
												           <p>
												           <span id="more" style="display: none">${p.LIGXFIC }</span>
												           </p>											       		
											       		</td>	
											        								
												    </tr>
												 </c:forEach>
											</tbody>
										
										</table>
									
										
										<div id="test1" style="visibility: hidden;">
											<span id="test1"></span>
										</div>
									</div>
					 
									
									
					
						    </div>
		
					       
					
					
					
						</div>	

				</div>
				
			</div>
						 
		</div>
		
	</jsp:attribute>
</mt:simpletemplate>





<script type="text/javascript">
	function chargerDateInterface(cbx) {

		var str = cbx.value;

		$.ajax({
					type : 'GET',
					url : "ListDateOracle/" + str,
					success : function(data) {
						var slctSubcat = $('#cbxdatenon');
						$('#cbxdatenon')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');
						for (var i = 0; i < data.length; i++) {
							var tableHtml = '<option>' + data[i] + '</option>';
							slctSubcat.append(tableHtml);
						}

					},
					error : function() {
						alert("Error");
					}

				});
		document.getElementById("divfiltre1").style.display = "block";
	}

	function chargerTableauOracle() {
		var interfac = document.getElementById("cbxInterface").value;
		var date2 = document.getElementById("cbxdatenon").value;
		document.getElementById("loading").style.display = "block";

		$
				.ajax({
					type : 'GET',
					//url: "/ListFICXINTErreurFiltrer/"+interfac+"/"+date2,
					url : "/ListFICXINTErreurFiltrer/" + interfac + "/" + date2,
					success : function(data) {
						var slctSubcat = $('#tableSageFichier tbody');

						slctSubcat.empty();

						for (var i = 0; i < data.length; i++) {

							var str = data[i].datxfic;
							var dateCreation1 = str.replace("T", " ");
							var datxfic = dateCreation1.replace("+00:00", "");
							var v1 = "'" + data[i].nomxfic + "'";
							var v2 = "'" + data[i].intxfic + "'";
							var v3 = "'" + data[i].ligxfic + "'";
							var tableHtml = '<tr>' + '<td>'
									+ data[i].flaxfic
									+ '</td>'
									+ '<td>'
									+ data[i].intxfic
									+ '</td>'
									+ '<td><a href="#" id="a2" hidden="">test</a><a id="aa2" onclick="downloadTxt('
									+ v1
									+ ' ,'
									+ v2
									+ ')" style="cursor: pointer;"><span class="glyphicon glyphicon-download" title="Télécharger">  '
									+ data[i].nomxfic
									+ '</span></a></td>'
									+ '<td>'
									+ data[i].depxfic
									+ '</td>'
									+ '<td>'
									+ datxfic
									+ '</td>'
									+ '<td><a href="#" id="a11" hidden="">test</a><a id="aa11" onclick="getWmsTxtOui('
									+ v3
									+ ')" style="cursor: pointer;"><span class="glyphicon glyphicon-download" title="Télécharger"> </span></a> <button onclick="myFunctionReadmore(this)" id="myBtn" style="background: none !important;border: none;padding: 0 !important;color: #069;font-size: 13px;">Afficher...</button><p><span id="more" style="display: none">'
									+ data[i].ligxfic + '</span></p></td>' +

									'</tr>';
							slctSubcat.append(tableHtml);

						}

						document.getElementById("loading").style.display = "none";
					},
					error : function() {
						alert("Error");
					}

				});

	}

	$(document).ready(function() {

		// 		$('#tableSageFichier').DataTable( {
		//  			"processing": true,
		//  	        "serverSide": true, 	        
		//  	        "ajax": "/data",
		// 			"aoColumns": 
		// 				[ 	 	 	        	
		// 					{"data":"flaxfic"},
		// 					{"data":"intxfic"},
		// 					{"data":"nomxfic"},
		// 					{"data":"depxfic"},
		// 					{"data":"datxfic"},
		// 					{"data":"ligxfic"},
		// 				] 

		//  	    } );

		// 		$('#tableSageFichier').DataTable({

		// 		});

		////Tabfilter

		 getFilterTab_11();
		//getFilterTab_22();
		//getFilterTab_33();

	});

	////////////////////////////////___TABLE FILTER___/////////////////////////////////////////////

	function getFilterTab_11() {
		var filtersConfig = {
			base_path : 'tablefilter/',
			paging : {
				results_per_page : [ 'Records: ', [ 10, 25, 50, 100 ] ]
			},
			state : {
				types : [ 'local_storage' ],
				filters : true,
				page_number : true,
				page_length : true,
				sort : true
			},
			alternate_rows : true,
			btn_reset : true,
			rows_counter : true,
			extensions : [ {
				name : 'sort'
			} ],

			auto_filter : {
				delay : 120
			//milliseconds
			},
			status_bar : true,
			msg_filter : 'Filtering...'
		};
		var tf = new TableFilter('tableSageFichier', filtersConfig);
		tf.init();

	}

	////////////////////////////////___ONGLET Erreur depuis EGO___/////////////////////////////////////////////

	function CheckedClick1(cb) {

		if (cb.checked == true) {
			document.getElementById("divdatenon").style.display = "block";
		} else {
			let element = document.getElementById("cbxInterface");
			element.value = "=== Sélectionner ===";
			document.getElementById("divdatenon").style.display = "none";
			document.getElementById("divfiltre1").style.display = "none";
			window.location.reload();

		}
	}

	function myFunctionReadmore(btn) {
		console.log(btn);

		var moreText = btn.parentElement.children[3].children[0];//document.getElementById("more");
		var btnText = btn.parentElement.children[2];//document.getElementById("myBtn");

		if (btnText.innerHTML == "Afficher...") {
			moreText.style.display = "block";
			btnText.innerHTML = "Masquer";
		}

		else if (btnText.innerHTML == "Masquer") {
			moreText.style.display = "none";
			btnText.innerHTML = "Afficher...";
		}

	}




	function downloadTxt(nomfichier, typefichier) {
		//alert(nomfichier);	
		//alert(typefichier);
		var str = nomfichier;
		var str2 = typefichier;
		$.ajax({
			type : 'GET',
			url : "/sagetoego/filetxt/" + str + "/" + str2,
			success : function(data) {
				var slctSubcat = $('#test2');
				slctSubcat.empty();
				var tableHtml = ' <span id="test2">' + data
				'</span>';
				slctSubcat.append(tableHtml);

			},
			error : function() {
				alert("Le fichier n'existe pas !! ");
			}

		}).done(function(data) {

			var filename = nomfichier;//"MyFileSage.txt";
			var text = data;
			var blob = new Blob([ text ], {
				type : 'text/plain'
			});
			var link = document.getElementById("a2");
			link.download = filename;
			link.href = window.URL.createObjectURL(blob);

			link.click();
			alert('Téléchargement terminé');
		});
	}




















// ===========================================================================
// ==================================AUTRE ONGLET=============================
// ===========================================================================



















	
	////////////////////////////////___ONGLET traités depuis x3___/////////////////////////////////////////////

	function CheckedClick(cb) {

		if (cb.checked == true) {
			//document.getElementById("divdate1").style.visibility = "visible"  ;
			document.getElementById("divdate1").style.display = "block";
			getdatedebut();

			// 	  			$("#cbxdate1").chosen({
			// 		            disable_search: false,
			// 		            placeholder_text_single: " -------- value  -------- ",
			// 		            no_results_text: "Aucun résultat ne correspond"
			// 		        });

		} else {
			document.cookie = "isChecked1=true";
			//document.getElementById("divdate1").style.visibility = "hidden"  ;
			document.getElementById("divdate1").style.display = "none";
			//document.getElementById("divdate2").style.visibility = "hidden"  ;
			window.location.reload();
			// $('#m3').removeClass('active'); 
			$('#m3').addClass('active');
			document.getElementById("menu3").setAttribute("class",
					"tab-pane fade active in");
			//document.getElementById("menu2").setAttribute("class","tab-pane fade");  
			//document.getElementById("menu1").setAttribute("class","tab-pane fade");  

		}
	}

	function getdatedebut() {
		$
				.ajax({
					type : 'GET',
					url : "/listdatedebut1",
					success : function(data) {
						var slctSubcat = $('#cbxdate1');
						$('#cbxdate2')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');
						$('#cbxdate1')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');

						for (var i = 0; i < data.length; i++) {
							$("#cbxdate1").append(
									"<option>" + data[i] + "</option>");
							//var tableHtml = 
							//'<option>' + data[i] + '</option>' ; 
							//slctSubcat.append(tableHtml);
						}
						$("#cbxdate1").trigger("liszt:updated");
					},
					error : function() {
						alert("Error");
					}

				});

	}

	function chargerdatefin(cbx) {

		document.getElementById("divouiligne").style.visibility = "hidden";
		document.getElementById("tableSageFichierLinesOui").style.visibility = "hidden";
		var str = cbx.value;

		$
				.ajax({
					type : 'GET',
					url : "/listdatefin1/dateCreation/" + str,
					success : function(data) {
						var slctSubcat = $('#cbxdate2');
						$('#cbxdate2')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');
						for (var i = 0; i < data.length; i++) {
							var tableHtml = '<option>' + data[i] + '</option>';
							slctSubcat.append(tableHtml);
						}
						$("#cbxdate2").trigger("liszt:updated");
					},
					error : function() {
						alert("Error");
					}

				});

		// 	    $("#cbxdate2").chosen({
		//             disable_search: false,
		//             placeholder_text_single: " -------- value  -------- ",
		//             no_results_text: "Aucun résultat ne correspond"
		//         });
	}

	function chargerTableauOui() {
		var datedebut = new Date(document.getElementById("cbxdate1").value);
		var datefin = new Date(document.getElementById("cbxdate2").value);
		document.getElementById("divouiligne").style.visibility = "hidden";
		document.getElementById("tableSageFichierLinesOui").style.visibility = "hidden";

		$
				.ajax({
					type : 'GET',
					url : "/ListFichierSageOuiDate1/dateCreation/" + datedebut
							+ "/" + datefin,
					success : function() {
						var slctSubcat = $('#tableSageFichierOui tbody');
						var modelimport = "";
						slctSubcat.empty();
						for (var i = 0; i < data.length; i++) {

							var str = data[i].credat_0;
							var dateCreation1 = str.replace("T", " ");
							var credat_0 = dateCreation1.replace("+00:00", "");
							var v1 = "'" + data[i].nomfichier_0 + "'";
							var v2 = "'" + data[i].typefichier_0 + "'";
							var tableHtml = ' <tr>'
									+ '<td><button class="btn btn-link" onclick="getAllSageLinesOui('
									+ data[i].idfichier_0
									+ ')"><span class="glyphicon glyphicon-search" title="Afficher">  Afficher</span></button></td>'
									+ '<td>'
									+ data[i].typefichier_0
									+ '</td>'
									+ '<td>'
									+ data[i].objetsage_0
									+ '</td>'
									+ '<td><a href="#" id="a2" hidden="">test</a><a id="aa2" onclick="downloadTxt('
									+ v1
									+ ' ,'
									+ v2
									+ ')" style="cursor: pointer;"><span class="glyphicon glyphicon-download" title="Télécharger">  '
									+ data[i].nomfichier_0 + '</span></a></td>'
									+
									// 	            		'<td><a href="#" id="a11" hidden="">test</a><a id="aa11" onclick="getSageTxtOui('+ data[i].IDFICHIER_0 +')" style="cursor: pointer;"><span class="glyphicon glyphicon-download" title="Télécharger"> </span></a> <button onclick="myFunctionReadmore(this)" title="Afficher le contenu" id="myBtn" style="background: none !important;border: none;padding: 0 !important;color: #069;font-size: 13px;">Afficher...</button><p><span id="more" style="display: none">' + data[i].contenuFichier + '</span></p></td>' + 	
									'<td>' + credat_0 + '</td>' +

									'</tr>';
							slctSubcat.append(tableHtml);
						}
					},
					error : function() {
						alert("Error");
					}

				});

	}

	function getAllSageLinesOui(idFichierWms) {

		var str = idFichierWms;

		$
				.ajax({
					type : 'GET',
					url : "/sagetoego/idFichierWms/" + str,
					success : function(data) {
						var slctSubcat = $('#tableSageFichierLinesOui tbody');
						slctSubcat.empty();
						for (var i = 0; i < data.length; i++) {
							var str = data[i].credat_0;
							var dateCreation1 = str.replace("T", " ");
							var credat_0 = dateCreation1.replace("+00:00", "");

							var tableHtml = ' <tr>' + '<td>'
									+ data[i].contligne_0 + '</td>' + '<td>'
									+ credat_0 + '</td>' + '</tr>';
							slctSubcat.append(tableHtml);

						}
						document.getElementById("tableSageFichierLinesOui").style.visibility = "visible";
						document.getElementById("divouiligne").style.visibility = "visible";
						//getFilterTab_OuiLigne(); 
					},
					error : function() {
						alert("Error");
					}

				});
	}

	function getWmsTxtOui(idFichierWms) {
		var d = new Date();
		var dat = d.getDate() + "-" + (d.getMonth() + 1) + "-"
				+ d.getFullYear();

		var str = idFichierWms;
		var filename = "MyFileLigne" + dat + ".txt";
		var text = str;
		var blob = new Blob([ text ], {
			type : 'text/plain'
		});
		var link = document.getElementById("a11");
		link.download = filename;
		link.href = window.URL.createObjectURL(blob);

		link.click();
		alert('Téléchargement terminé');

	}

	

	////////////////////////////////___ONGLET Non traités___/////////////////////////////////////////////

	function CheckedClickNon(cb) {

		if (cb.checked == true) {
			document.getElementById("divdate1Non").style.visibility = "visible";

			getdatedebutNon();

			// 	  			$("#cbxdate1").chosen({
			// 		            disable_search: false,
			// 		            placeholder_text_single: " -------- value  -------- ",
			// 		            no_results_text: "Aucun résultat ne correspond"
			// 		        });

		} else {
			document.cookie = "isChecked2=true";
			document.getElementById("divdate2").style.visibility = "hidden";
			//document.getElementById("divdate2").style.visibility = "hidden"  ;
			window.location.reload();
			// $('#m3').removeClass('active'); 
			$('#m3').addClass('active');
			document.getElementById("menu3").setAttribute("class",
					"tab-pane fade active in");
			//document.getElementById("menu2").setAttribute("class","tab-pane fade");  
			//document.getElementById("menu1").setAttribute("class","tab-pane fade");  

		}
	}

	function getdatedebutNon() {
		$
				.ajax({
					type : 'GET',
					url : "/listdatedebut2",
					success : function(data) {
						var slctSubcat = $('#cbxdate1Non');
						$('#cbxdate2Non')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');
						$('#cbxdate1Non')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');

						for (var i = 0; i < data.length; i++) {
							$("#cbxdate1Non").append(
									"<option>" + data[i] + "</option>");
							//var tableHtml = 
							//'<option>' + data[i] + '</option>' ; 
							//slctSubcat.append(tableHtml);
						}
						$("#cbxdate1Non").trigger("liszt:updated");
					},
					error : function() {
						alert("Error");
					}

				});

	}

	function chargerdatefinNon(cbx) {

		document.getElementById("divouiligneNon").style.visibility = "hidden";
		document.getElementById("tableSageFichierLinesNon").style.visibility = "hidden";

		var str = cbx.value;

		$
				.ajax({
					type : 'GET',
					url : "/listdatefin2/dateCreation/" + str,
					success : function(data) {
						var slctSubcat = $('#cbxdate2Non');
						$('#cbxdate2Non')
								.empty()
								.append(
										'<option disabled selected>=== Sélectionner ===</option>');
						for (var i = 0; i < data.length; i++) {
							var tableHtml = '<option>' + data[i] + '</option>';
							slctSubcat.append(tableHtml);
						}
						$("#cbxdate2Non").trigger("liszt:updated");
					},
					error : function() {
						alert("Error");
					}

				});

		// 	    $("#cbxdate2").chosen({
		//             disable_search: false,
		//             placeholder_text_single: " -------- value  -------- ",
		//             no_results_text: "Aucun résultat ne correspond"
		//         });
	}

	function chargerTableauNon(cbx) {
		var datedebut = new Date(document.getElementById("cbxdate1Non").value);
		var datefin = new Date(document.getElementById("cbxdate2Non").value);
		document.getElementById("divouiligneNon").style.visibility = "hidden";
		document.getElementById("tableSageFichierLinesNon").style.visibility = "hidden";
		$
				.ajax({
					type : 'GET',
					url : "/ListFichierSageOuiDate2/dateCreation/" + datedebut
							+ "/" + datefin,
					success : function(data) {
						var slctSubcat = $('#tableSageFichierNon tbody');
						var modelimport = "";
						slctSubcat.empty();
						for (var i = 0; i < data.length; i++) {

							var str = data[i].credat_0;
							var dateCreation1 = str.replace("T", " ");
							var credat_0 = dateCreation1.replace("+00:00", "");
							var tableHtml = ' <tr>'
									+ '<td><button class="btn btn-link" onclick="getAllSageLinesNon('
									+ data[i].idfichier_0
									+ ')"><span class="glyphicon glyphicon-search" title="Afficher">'
									+ data[i].transfere_0
									+ '</span></button></td>'
									+ '<td>'
									+ data[i].typefichier_0
									+ '</td>'
									+ '<td>'
									+ data[i].objetsage_0
									+ '</td>'
									+ '<td><a href="#" id="a1" hidden="">test</a><a id="aa1" onclick="getWmsTxtNon('
									+ data[i].idfichier_0
									+ ')" style="cursor: pointer;"><span class="glyphicon glyphicon-download" title="Télécharger">'
									+ data[i].nomfichier_0 + '</span></a></td>'
									+
									// 	            		'<td><a href="#" id="a11" hidden="">test</a><a id="aa11" onclick="getSageTxtOui('+ data[i].IDFICHIER_0 +')" style="cursor: pointer;"><span class="glyphicon glyphicon-download" title="Télécharger"> </span></a> <button onclick="myFunctionReadmore(this)" title="Afficher le contenu" id="myBtn" style="background: none !important;border: none;padding: 0 !important;color: #069;font-size: 13px;">Afficher...</button><p><span id="more" style="display: none">' + data[i].contenuFichier + '</span></p></td>' + 	
									'<td>' + credat_0 + '</td>' +

									'</tr>';
							slctSubcat.append(tableHtml);
						}
					},
					error : function() {
						alert("Error");
					}

				});

	}

	function getAllSageLinesNon(idFichierWms) {

		var str = idFichierWms;

		//var categoryId = $(this).val();
		$
				.ajax({
					type : 'GET',
					url : "/sagetoego2/idFichierWms/" + str,
					success : function(data) {
						var slctSubcat = $('#tableSageFichierLinesNon tbody');
						slctSubcat.empty();
						for (var i = 0; i < data.length; i++) {
							var str = data[i].credat_0;
							var dateCreation1 = str.replace("T", " ");
							var credat_0 = dateCreation1.replace("+00:00", "");

							var tableHtml = ' <tr>' + '<td>'
									+ data[i].contligne_0 + '</td>' + '<td>'
									+ credat_0 + '</td>' + '</tr>';
							slctSubcat.append(tableHtml);

						}
						document.getElementById("tableSageFichierLinesNon").style.visibility = "visible";
						document.getElementById("divouiligneNon").style.visibility = "visible";
						//getFilterTab_OuiLigne(); 
					},
					error : function() {
						alert("Error");
					}

				});
	}

	function getWmsTxtNon(idFichierWms) {
		var str = idFichierWms;
		//var categoryId = $(this).val();
		$.ajax({
			type : 'GET',
			url : "/egotosage2/idFichierWms0/" + str,
			success : function(data) {
				var slctSubcat = $('#test2');
				slctSubcat.empty();
				var tableHtml = ' <span id="test2">' + data
				'</span>';
				slctSubcat.append(tableHtml);

			},
			error : function() {
				alert("Error");
			}

		}).done(function(data) {
			//alert('fg');
			//alert(data);
			var filename = "MyFileWMS.txt";
			var text = data;
			var blob = new Blob([ text ], {
				type : 'text/plain'
			});
			var link = document.getElementById("a");
			link.download = filename;
			link.href = window.URL.createObjectURL(blob);

			link.click();
			alert('Téléchargement terminé');
		});
	}
</script>




