<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<h1>User Search</h1>
    <div class='form-center'>
    
    <form method="post" action="deleteUser.jsp">
        <label for="searchTerm">Search Term:</label>
        <input type="text" name="searchTerm" id="searchTerm" placeholder="Enter Email" required>
        <input type="submit" value="Search">
    </form>
    </div>

    <%-- Display search results --%>
    <%@ page import="java.sql.*" %>
    <%@ page import="org.postgresql.jdbc.*" %>

    <%-- Get search term from form submission --%>
    <% String searchTerm = request.getParameter("searchTerm"); %>

    <%-- Connect to PostgreSQL database using JDBC --%>
    <% String url = "jdbc:postgresql://localhost:5432/postgres"; %>
    <% String username = "postgres"; %>
    <% String password = "krishna"; %>

    <% try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);

        String sql = "SELECT * FROM userinfo WHERE email ILIKE ?";
        PreparedStatement pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, "%" + searchTerm + "%");
        ResultSet rs = pstmt.executeQuery();

        if (rs.next()) { %>
            <table>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Gender</th>
                    <th>Email</th>
                    <th>Phone No</th>
                    <th>Action</th>
                </tr>
                <tr>
                    <td><%= rs.getString("firstname") %></td>
                    <td><%= rs.getString("lastname") %></td>
                    <td><%= rs.getString("gender") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td>
                        <form method="post" action="delete.jsp">
                            <input type="hidden" name="userId" value="<%= rs.getString("email") %>">
                            <input type="submit" value="Delete">
                        </form>
                    </td>
                </tr>
            </table>
        <% } else { %>
            <p><i>No user found.</i></p>
        <% }

        rs.close();
        pstmt.close();
        conn.close();
    }
    catch (Exception e) {
        e.printStackTrace();
    } %>
</body>
</html>
