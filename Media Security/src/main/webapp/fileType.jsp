<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="jakarta.servlet.http.HttpServletRequest"%>
<%@ page import="jakarta.servlet.http.HttpServletResponse"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="design/filetype.css">
<meta charset="UTF-8">
<title>Home</title>
</head>
<body>


<div>
<form action="TypeServ" method="POST">
 <div class="mode-container">
  <input type="radio" name="mode" id="encrypt" value="encrypt" checked>
  <label for="encrypt">Encrypt</label>
  <input type="radio" name="mode" id="decrypt" value="decrypt">
  <label for="decrypt">Decrypt</label>
</div>

<div class="mode-container-1">
<input type=radio name="file" id="1" value="text" checked>
<label for="1">Text</label>

<input type=radio name="file" id="2" value="image">
<label for="2">Image</label>

<input type=radio name="file" id="3" value="audio">
<label for="3">Audio</label>

<input type=radio name="file" id="4" value="video">
<label for="4">Video</label>

<input type="hidden" name="username" value="<%=(String) session.getAttribute("email")%>">

</div>
<input type="submit" value="Submit">
</form>
</div>




</body>
</html>