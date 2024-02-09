<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
 <%@ page import="Main.AES" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="design/details.css">
<title>Download file</title>
</head>
<body>
<button onClick='document.location="User.jsp"'>Home</button>
<%
  String status=request.getAttribute("status").toString();
  String name=request.getAttribute("fileName").toString();
  String exten=request.getAttribute("Extension").toString();
  String fullname=name+"."+exten;
  String fType=request.getAttribute("ftype").toString();
String id=AES.ImageStore.getID();
%>
<form action=DownloadImg.jsp method="post">
<h1>Your File <%=status %> Successfully</h1><br>
 <h3>Details</h3><br>
<p>File Name:<%=fullname%></p><br>
<p>File ID:<%=id %></p><br>
<p><i>Save ID to download this file again</i></p><br>
 <p>Size:<%=AES.Info.size()%></p><br>
<p>Type:<%=fType %></p><br>
<p>Security Status:<%=status.toUpperCase() %></p><br>
<input type=hidden name=id value=<%=id%>>
<input type=hidden name=fname value=<%=name %>>
<input type=hidden name=extension value=<%=exten %>>
<input type=submit value=Download>
<br>
<br>

</form>
<button onClick='document.location="fileType.jsp"'>Secure More File</button>
</body>
</html>