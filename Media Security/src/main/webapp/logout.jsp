<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>logout</title>
</head>
<body>
<%
  // invalidate session and redirect to index.html on logout
   if (request.getParameter("logout") != null) {
            session.invalidate();
            response.sendRedirect("index.html");
        }
%>

</body>
</html>