<%@ tag language="java" pageEncoding="ISO-8859-1"%>
<%@ attribute name="title" required="true" rtexprvalue="true" %>
<%@ attribute name="content" fragment="true" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
    
<!DOCTYPE html>
<html>
<head>
<title>Monitoring</title>
<meta charset="utf-8"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="${contextPath}/images/favicon.png" />

<!-- cdn -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> 
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
 
<!-- Local -->
<link href="${contextPath}/css/myStyle.css" rel="stylesheet" type="text/css"> 
<link href="${contextPath}/css/bootstrap.css" rel="stylesheet" type="text/css"> 
<script src="${contextPath}/js/jquery-3.5.1.js"></script>
<script src="${contextPath}/js/bootstrap.js"></script>

<!-- Table filter -->
<script src="${contextPath}/js/tablefilter/tablefilter.js"></script> 
<script src="${contextPath}/js/tablefilter/tf-0-539d4df8c7c919f5b3d8.js"></script> 
<link href="${contextPath}/js/tablefilter/style/tablefilter.css" rel="stylesheet" type="text/css"> 

 

<!-- datatable -->
<link href="https://cdn.datatables.net/1.10.22/css/jquery.dataTables.min.css" rel="stylesheet" />
 <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>

</head>
<body>

	<header>
		<nav class="navbar navbar-default">

			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"	data-target="#myNavbar">
						<span class="icon-bar"></span> <span class="icon-bar"></span> 
						<span class="icon-bar"></span>
					</button>
					<a  class="navbar-brand active">MONITORING</a>
				</div>
				<div class="collapse navbar-collapse" id="myNavbar">
					<ul class="nav navbar-nav">
						<li><a href="/home">ACCUEIL</a></li>
						<li><a href="/egotosage">EGO TO SAGE</a></li>
						<li><a href="/sagetoego">SAGE TO EGO</a></li>
					</ul>
					<!-- 				      <ul class="nav navbar-nav navbar-right"> -->
					<!-- 				        <li><a href="#"><span class="glyphicon glyphicon-user"></span> Sign Up</a></li>  -->
					<%-- 			        	<li><a href="/login?logout" text="${#httpServletRequest.remoteUser}"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>  --%>
					<!-- 				      </ul> -->
				</div>
			</div>
		</nav>

	</header>
	<section>
		<jsp:invoke fragment="content"></jsp:invoke>
	</section>
<!-- 	<div class="footer-copyright text-center py-3">©Copyright 2020</div> -->
	
<script type="text/javascript">
   

	$(document).ready(function(){

		 
		
	});


	 
</script>
</body>
</html>

