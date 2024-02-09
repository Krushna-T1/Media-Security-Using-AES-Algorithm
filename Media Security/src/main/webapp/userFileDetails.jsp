<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <title>User Search</title>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="design/searchUser.css">
</head>
<body>
<a href="Admin.jsp" class="btn btn-primary">Back</a>

<div class='form-center'>

    <form method="post" action="userFileDetails.jsp">
        <label for="searchTerm">Search User:</label>
        <input type="text" name="searchTerm" id="searchTerm" placeholder="Enter Email" required>
        <input type="submit" value="Search">
    </form>
</div>

<%
    String searchTerm = request.getParameter("searchTerm");

    // Connect to PostgreSQL database using JDBC
    String url = "jdbc:postgresql://localhost:5432/postgres";
    String username = "postgres";
    String password = "krishna";

    try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);

        // Use a prepared statement to prevent SQL injection for userinfo table
        String sql = "SELECT * FROM userinfo WHERE email ILIKE ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + searchTerm + "%");
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) {
%>
            
            <table border=1>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                   <th>Gender</th>
                    <th>Email</th>
                    <th>Phone No</th>
                    
                </tr>
                <tr>
                    <td><%= rs.getString("firstname") %></td>
                    <td><%= rs.getString("lastname") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    
                </tr>
            </table>

<%
            rs.close();
            pstmt.close();

            // Use a prepared statement to prevent SQL injection for file_data table
            String sql1 = "SELECT * FROM file_data WHERE username ILIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql1);
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs1 = ps.executeQuery();

            int totalFiles = 0;
            int encryptedFiles = 0;
            int decryptedFiles = 0;
            double totalPrice = 0;

            if (rs1.next()) {
%>
                <h1>User File Information</h1>
                <table border=1>
                    <tr>
                        <th>File ID</th>
                        <th>Mode</th>
                        <th>File Type</th>
                        <th>Price Paid</th>
                    </tr>
<%
                do {
                    totalFiles++;
                    String fileMode = rs1.getString("mode");
                    if ("encrypt".equalsIgnoreCase(fileMode)) {
                        encryptedFiles++;
                    } else if ("decrypt".equalsIgnoreCase(fileMode)) {
                        decryptedFiles++;
                    }
                    double price = Double.parseDouble(rs1.getString("price"));
                    totalPrice +=price;
                    
%>
                    <tr>
                        <td><%= rs1.getString("file_id") %></td>
                 
                        <td><%= rs1.getString("mode") %></td>
                        <td><%= rs1.getString("file_type") %></td>
                        <td><%=rs1.getString("price") %></td>
                    </tr>
<%
                } while (rs1.next());
%>
                </table>
                <br>
                <br>
                <table>
                <tr>
                <th>Total Files</th>
                <th>Encrypted Files</th>
                <th>Decrypted Files</th>
                <th>Paid</th>
                </tr>
                <tr>
                <td><%= totalFiles %></td>
                <td><%= encryptedFiles %></td>
                <td><%= decryptedFiles %></td>
                <td><%=totalPrice %></td>
                </tr>
                </table>
<%
            } else {
%>
                <p><i>File Data Not Found</i></p>
<%
            }

            rs1.close();
            ps.close();
            conn.close();
        } else {
%>
            <p><i>User Not Found</i></p>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
</body>
</html>

