<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="design/userList.css">
    <title>User Info</title>
   
</head>
<body>
<a href="Admin.jsp" class="btn btn-primary">Back</a>
    <h1>Users List</h1>
    <table>
        <tr>
            <th>ID</th>
            <th>First Name</th>
            <th>Last Name</th>
            <th>Gender</th>
            <th>Email</th>
            <th>Phone</th>
        </tr>
        <% 
        try {
            Class.forName("org.postgresql.Driver"); 
            Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM userinfo");
            
            while (rs.next()) {
                int id = rs.getInt("id");
                String userName = rs.getString("firstname");
                String lname=rs.getString("lastname");
                String gen=rs.getString("gender");
                String userEmail = rs.getString("email");
               
                String  phone =rs.getString("phone");
                
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= userName %></td>
                     <td><%= lname %></td>
                      <td><%= gen %></td>
                    <td><%= userEmail %></td>
                    <td><%=phone %></td>
                </tr>
                <%
            }
            
            rs.close();
            stmt.close();
            conn.close();
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        %>
    </table>
</body>
</html>
