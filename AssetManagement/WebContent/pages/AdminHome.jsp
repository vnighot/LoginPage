<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>AdminMain</title>
<meta name="viewport" content="width=device-width,initial-scale=1">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/w3.css">
<style>
li a.active {
	color:#000;
	background-color:#ccc;
}
</style>
<script src="${pageContext.request.contextPath}/js/jquery-1.12.3.min.js"></script>
<script>
$(document).ready(function(){
    $("a").click(function(){
        $("a").removeClass("active");
        $(this).addClass("active");
    });
});
</script>
<body>
<header style="padding:2%;background-color:#dddddd;border:navy 1px solid;" class="w3-card-2">
<center><img  width="5%" id="logo" src="${pageContext.request.contextPath}/res/logo.png"><img  id="headerimg" width="60%" src="${pageContext.request.contextPath}/res/assetmanagementheader.png"></center>
</header>
<div class="w3-blue-grey" style="text-align:right">
Welcome ${user.userName}<img alt="" src="${pageContext.request.contextPath}/res/user.png" height="25" width="25">
</div>
<ul class="w3-navbar w3-navyblue w3-card-2">
	<li><a href="${pageContext.request.contextPath}/pages/back1.jsp" target="content">Home</a></li>
	<li class="w3-dropdown-hover">
	
      <a href="#">Asset</a>
      <div class="w3-dropdown-content w3-white w3-card-4">
      	
      	<a href="prepareAddAsset" target="content">Add Asset</a>
		<a href="goToModifyPage" target="content">Modify Asset</a>
        <a href="goToDeletePage" target="content">Delete Asset</a>
      </div>
    </li>
	<li><a href="getAllocated" target="content">Allocated Assets</a></li>
  	<li><a href="getUnallocated" target="content">Unallocated Assets</a></li>
   	<li><a href="RaisedRequests" target="content">All Requests</a></li>
  	<li class="w3-right"><a href="Logout" target="_top">Logout</a></li>
</ul>

<div>

<iframe src="${pageContext.request.contextPath}/pages/back1.jsp"  name="content"  width="100%" style="height:88%;" class="w3-border-0"></iframe>

</div>
<footer class="w3-container w3-navyblue" style="text-align:right">
Copyright&copy; All rights reserved&reg;
</footer>
</body>
</html>