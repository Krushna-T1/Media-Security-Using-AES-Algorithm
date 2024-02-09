<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Panel</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
        background-image:url("design/icon/admin_background.jpg");
        background-size: cover;
			background-position: center;
			background-repeat: no-repeat;
            padding: 20px;
        }
        h1{
           color:blue;
        }
        
        .logo {
            width: 150px;
            height: 150px;
            margin: 0 auto;
            display: block;
            margin-bottom: 30px;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            align-items: center;
            flex-wrap: wrap;
        }
        .btn-container a {
            margin: 10px;
            text-align: center;
            display: flex;
            background-image:linear-gradient(45deg,blue,green);
            flex-direction: column;
            align-items: center;
        }
        .btn-container img {
            width: 50px;
            height: 50px;
            margin-bottom: 10px;
        }
        .btn-name {
            margin-top: 5px;
        }
        table
        {
        
        background:black;}
        
        td
        {
        color:white;}
        th
        {
        color:white;
        }
        
        
    </style>
</head>
<body>
    <div class="container text-center">
        <img src="design/icon/admin.png" alt="Logo" class="logo">
        <h1 style="color:red;">Admin Panel</h1>
        
        <div class="btn-container">
            <a href="userList.jsp" class="btn btn-primary">
                <img src="design/icon/user.png" alt="User Icon">
                <br>
                <span class="btn-name">User List</span>
            </a>
            <a href="searchUser.jsp" class="btn btn-primary">
                <img src="design/icon/search.png" alt="Search Icon">
                <br>
                <span class="btn-name">Search User</span>
            </a>
            <a href="userFileDetails.jsp" class="btn btn-primary">
                <img src="design/icon/file.png" alt="File Icon">
                <br>
                <span class="btn-name">User File Details</span>
            </a>
            <a href="deleteUser.jsp" class="btn btn-primary">
                <img src="design/icon/delete.png" alt="Delete Icon">
                <br>
                <span class="btn-name">Delete User</span>
            </a>
            <a href="report.jsp" class="btn btn-primary">
                <img src="design/icon/report.png" alt="Delete Icon">
                <br>
                <span class="btn-name">Reports</span>
            </a>
        </div>
    </div>
    <br>
    
    <% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

                // Use a prepared statement to prevent SQL injection for file_data table
                String sql = "SELECT * FROM file_data";
                pstmt = conn.prepareStatement(sql);
               
                rs = pstmt.executeQuery();

                int totalFiles = 0;
                int encryptedFiles = 0;
                int decryptedFiles = 0;
                double totalPrice = 0;

                if (rs.next()) {
    %>
                   
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
                    
    <%              } while (rs.next()); %>
                        
    <%          } else { %>
                    <p style=color:red;><i>No file data found </i></p>
  <%  }       
          
    %>

    <br>
    <table border=2 class="table table-bordered">
  
<tbody>
<tr>
<td>Total Files:</td>
<td><%= totalFiles %></td>

</tr>
<tr>

<td>Encrypted Files:</td>
<td><%= encryptedFiles %></td>
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
            }
        %>
    
    
    
    
    <br>
</body>
</html>
