<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="design/login.css">
<title>Login Form</title>
</head>
<body style='background-image:url("design/icon/loginback.jpg");'>
 <div class="container">
<form action="LogServ" method="POST">
    <h1>Login</h1>
    <p>Please fill in this form to login in an account.</p>
    <hr>

    <label for="email"><b>Email</b></label>
    <input type="email" placeholder="Enter Email" name="email" id="email" required >
  <p style=color:red;><i>${errorlogin}</i></p>
 
    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" id="psw" required>
<p style=color:red;><i>${errorpass}</i><p>
<p style=color:red;><i>${erroradmin}</i><p>
   
     <hr>
   <button type=submit class="signinbtn" >Login</button><br>
   <p>Don't Have Account?<a href="Registration.jsp">sign up</a></p>
  </form>
 </div>
</body>
</html>