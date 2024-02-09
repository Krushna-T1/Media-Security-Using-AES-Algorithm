<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="design/userProfile.css">
</head>
<body>
<div class="container">
    <h1>User Profile</h1>

    <% 
    
        // Check if user is logged in, otherwise redirect to login page
        if (session.getAttribute("email") == null) {
            response.sendRedirect("Login.jsp");
        } else {
            String username = session.getAttribute("email").toString();
           // String searchTerm = request.getParameter("searchTerm");
%>
<p><%=username%></p>
<form action="User.jsp" method="post">
<input type=hidden value="logout" name="logout">
        <input type="submit" value="logout" class="btn btn-primary">
    </form>
    <% if(request.getParameter("logout")!=null){
    	session.invalidate();
    	response.sendRedirect("index.html");}%>
    
<a href="fileType.jsp" class="btn btn-primary">Secure Files</a>
<br>
<br>
<% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

                // Use a prepared statement to prevent SQL injection for file_data table
                String sql = "SELECT * FROM file_data WHERE username = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, username);
                rs = pstmt.executeQuery();

                int totalFiles = 0;
                int encryptedFiles = 0;
                int decryptedFiles = 0;
                double totalPrice = 0;

                if (rs.next()) {
    %>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>File ID</th>
                                <th>File Type</th>
                                <th>Mode</th>
                                <th>Password</th>
                                <th>Price Paid</th>
                            </tr>
                        </thead>
                        <tbody>
    <%

                    do {
                        totalFiles++;
                        String fileMode = rs.getString("mode");
                        if (fileMode.equals("encrypt")) {
                            encryptedFiles++;
                        } else if (fileMode.equals("decrypt")) {
                            decryptedFiles++;
                        }
                        double price = Double.parseDouble(rs.getString("price"));
                        totalPrice += price;
    %>
                        <tr>
                            <td><%= rs.getString("file_id") %></td>
                            <td><%= rs.getString("file_type") %></td>
                            <td><%= fileMode %></td>
                            <td><%= rs.getString("password") %></td>
                            <td><%= price %></td>
                        </tr>
    <%              } while (rs.next()); %>
                        </tbody>
                    </table>
    <%          } else { %>
                    <p><i>No file data found for this user.</i></p>
  <%  }       
          
    %>

    <br>
    <table class="table table-bordered">
  
<tbody>
<tr>
<td>Total Files:</td>
<td><%= totalFiles %></td>
</tr>
<tr>
<td>Encrypted Files:</td>
<td><%= encryptedFiles %></td>
</tr>
<tr>
<td>Decrypted Files:</td>
<td><%= decryptedFiles %></td>
</tr>
<tr>
<td>Total Paid:</td>
<td><%= totalPrice %></td>
</tr>
</tbody>
</table>
<form action=bill.jsp method="post">
<input type=hidden value="<%=username %>" name=uname>
<input type=hidden value="<%=totalPrice %>" name=tprice>
<input type=hidden value="<%= totalFiles %>" name="tfiles">
<input type=submit value=Bill class="btn btn-Primary">
</form>
<%
  } 
            catch (Exception e) {
                e.printStackTrace();
            }
            finally {
                try { 
                    if (rs != null) {
                        rs.close();
                    }
                    if (pstmt != null) {
                        pstmt.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
                catch (SQLException ex) {
                    ex.printStackTrace();
                }
          
            }}
        %>


 
  
</div>
</body>
</html>






