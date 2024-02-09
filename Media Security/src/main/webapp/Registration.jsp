<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="design/registration.css">
<title>Registration Form</title>

</head>
<body style='background-image:url("design/icon/loginback.jpg");'>

<form action="RegServ" method="POST">
  <div class="container">
    <h1>Register</h1>
    <p>Please fill in this form to create an account.</p>
    <hr>
  <label for="uname"><b>First Name</b></label>
   <input type="text" placeholder="Enter Name" name="uname" id="fname" required>
   
    <label for="uname"><b>Last Name</b></label>
   <input type="text" placeholder="Enter " name="lname" id="lname" required><br>
   
 <label for="gender">Gender</label><br>
  <input type="radio" name="gender" id="m" value="male" checked>
  <label for="m">Male</label><br>
  <input type="radio" name="gender" id="f" value="female">
  <label for="f">Female</label>
  <br>
  <br>
  <br>
    
    
    <label for="email"><b>Email</b></label>
    <input type="email" placeholder="Enter Email" name="email" id="email" required>
    
    <p><i>${invalidmail}</i></p>
    <p><i>${existuser}</i></p>
    
     <label for="no"><b>Phone Number</b></label>
    <input type="text" pattern="\d*" minlength=10 maxlength=10 placeholder="Enter Phone no" name="no" id="no" required>

    <label for="psw"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" name="psw" id="psw" minlength=4 required>
    
    <p><i>${errormsg}</i></p>

    <label for="psw-repeat"><b>Repeat Password</b></label>
    <input type="password" placeholder="Repeat Password" name="psw-repeat" id="psw-repeat" minlength=4 required>
    <hr>
   

    <button type="submit" class="registerbtn">Register</button>
  </div>
  
  <div class="container signin">
    <p>Already have an account? <a href="Login.jsp">Sign in</a>.</p>
  </div>
</form>



</body>
</html>