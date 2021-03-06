<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE HTML>
<html>
<head>
<title>View Requests</title>
<link href="${pageContext.request.contextPath}/css/w3.css"
	REL="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath}/js/add_asset.js"
	type="text/javascript"></script>
<style>
a:HOVER {
	background-color: silver;
	color: teal;
}
</style>
</head>
<%
	String exportToExcel = (String)request.getAttribute("exportToExcel");
	if (exportToExcel != null
			&& exportToExcel.toString().equalsIgnoreCase("YES")) {
		response.setContentType("application/vnd.ms-excel");
		response.setHeader("Content-Disposition", "inline; filename="
				+ "requests.xls");

	}
%>
<body align="center">
	<hr>
	<div class="w3-container">
		<table class="w3-table w3-striped w3-bordered w3-border w3-card-4"
			style="font-size: small;">
			<caption class="w3-container w3-darkteal" style="font-size: x-large;">
				ASSET REQUEST LIST

				<%
				exportToExcel = (String)request.getAttribute("exportToExcel");
				if (exportToExcel == null) {
			%>
				<a class="w3-right"
					href="${pageContext.request.contextPath}/GenerateRequestsReport"
					style="text-decoration: none; font-size: x-large;"><img alt="" src="${pageContext.request.contextPath}/res/save.png" height="35" width="35"></a>
				<%
					}
				%>
			</caption>
			<tr class="w3-teal" style="font-size: small;">
				<th>Request Id</th>
				<th>Asset Id</th>
				<th>Employee Id</th>
				<th>Manager Id</th>
				<th>Requirement</th>
				<th>Status</th>
				<th>User Id</th>
				<th></th>
				<th></th>
			</tr>
			<c:forEach items="${requestList}" var="assetRequest">
				<tr>
					<td>${assetRequest.requestId}</td>
					<td><a href="ViewAsset?id=${assetRequest.asset.assetId}"
						style="text-decoration: none">${assetRequest.asset.assetId}</a></td>
					<td><a href="ViewEmployee?id=${assetRequest.employee.empNo}"
						style="text-decoration: none">${assetRequest.employee.empNo}</a></td>
					<td><a href="ViewEmployee?id=${assetRequest.manager.empNo}"
						style="text-decoration: none">${assetRequest.manager.empNo}</a></td>
					<td>${assetRequest.requirement}</td>
					<td>${assetRequest.status}</td>
					<td><a href="ViewAdmin?id=${assetRequest.user.userId}"
						style="text-decoration: none">${assetRequest.user.userId}</a></td>
					<c:if test="${assetRequest.status=='Pending'}">
						<td><a href="Accept?id=${assetRequest.requestId}"
							class="w3-border w3-padding w3-round"
							style="text-decoration: none">Accept</a></td>
						<td><a href="Deny?id=${assetRequest.requestId}"
							class="w3-border w3-padding w3-round"
							style="text-decoration: none">Deny</a></td>
					</c:if>
				</tr>
			</c:forEach>
		</table>
	</div>
	<hr>
	<c:if test="${asset.assetName ne null}">
		<div id="id01" class="w3-modal w3-animate-zoom" style="display: block">
			<div class="w3-modal-content w3-card-4">
				<header class="w3-container w3-darkteal">
					<span
						onclick="document.getElementById('id01').style.display='none'"
						class="w3-closebtn">&times;</span>
					<h2>ASSET INFO</h2>
				</header>
				<table class="w3-table w3-striped w3-bordered w3-border w3-card-4"
					style="font-size: small;">

					<tr class="w3-teal" style="font-size: small;">
						<th>AssetName</th>
						<th>AssetId</th>
						<th>PurchaseDate</th>
						<th>UnitPrice</th>
						<th>AssetType</th>
						<th>Category</th>
						<th>Quantity</th>
						<th>AssetDes</th>
					</tr>
					<tr>
						<td>${asset.assetName}</td>
						<td>${asset.assetId}</td>
						<td>${asset.purchaseDate}</td>
						<td>${asset.unitPrice}</td>
						<td>${asset.assetType}</td>
						<td>${asset.category}</td>
						<td>${asset.quantity}</td>
						<td>${asset.assetDes}</td>
					</tr>
				</table>
			</div>
			<input type="text" id="id" style="display: none" /> <input
				type="text" id="name" style="display: none" /> <input type="date"
				id="date" style="display: none" /> <input type="text" id="price"
				style="display: none" /> <input type="text" id="type"
				style="display: none" /> <input type="text" id="cat"
				style="display: none" /> <input type="text" id="qty"
				style="display: none" /> <input type="text" id="des"
				style="display: none" />
			<footer class="w3-container w3-darkteal">
			</footer>
		</div>
	</c:if>
	<c:if test="${employee.empName ne null}">
		<div id="id02" class="w3-modal w3-animate-zoom" style="display: block">
			<div class="w3-modal-content w3-card-4">
				<header class="w3-container w3-darkteal">
					<span
						onclick="document.getElementById('id02').style.display='none'"
						class="w3-closebtn">&times;</span>
					<h2>Employee INFO</h2>
				</header>
				<table class="w3-table w3-striped w3-bordered w3-border w3-card-4"
					style="font-size: small;">

					<tr class="w3-teal" style="font-size: small;">
						<th>Employee Id</th>
						<th>Employee Name</th>
						<th>Designation</th>
						<th>Hire Date</th>
						<th>Department Name</th>
					</tr>
					<tr>
						<td>${employee.empNo}</td>
						<td>${employee.empName}</td>
						<td>${employee.designation}</td>
						<td>${employee.hireDate}</td>
						<td>${employee.department}</td>
					</tr>
				</table>
			</div>
			<footer class="w3-container w3-darkteal">
			</footer>
		</div>
	</c:if>
	<c:if test="${admin.empName ne null}">
		<div id="id03" class="w3-modal w3-animate-zoom" style="display: block">
			<div class="w3-modal-content w3-card-4">
				<header class="w3-container w3-darkteal">
					<span
						onclick="document.getElementById('id03').style.display='none'"
						class="w3-closebtn">&times;</span>
					<h2>Employee INFO</h2>
				</header>
				<table class="w3-table w3-striped w3-bordered w3-border w3-card-4"
					style="font-size: small;">

					<tr class="w3-teal" style="font-size: small;">
						<th>Employee Id</th>
						<th>Employee Name</th>
						<th>Designation</th>
						<th>Hire Date</th>
						<th>Department Name</th>
					</tr>
					<tr>
						<td>${admin.empNo}</td>
						<td>${admin.empName}</td>
						<td>${admin.designation}</td>
						<td>${admin.hireDate}</td>
						<td>${admin.department}</td>
					</tr>
				</table>
			</div>
			<footer class="w3-container w3-darkteal">
			</footer>
		</div>
	</c:if>
</body>
</html>
