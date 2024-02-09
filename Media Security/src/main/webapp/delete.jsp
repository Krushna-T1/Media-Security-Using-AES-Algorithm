<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Delete User</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #333;
        }
        p {
            margin: 1em 0;
        }
        button {
            background-color: #4CAF50;
            border: none;
            color: white;
            padding: 0.5em 1em;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 1em;
            border-radius: 0.3em;
            cursor: pointer;
        }
        button:hover {
            background-color: #3e8e41;
        }
    </style>
</head>
<body>
    <h1>Delete User</h1>
    <%-- Retrieve userId from request parameter --%>
    <% String userId = request.getParameter("userId"); %>

    <%-- Connect to PostgreSQL database using JDBC --%>
    <%@ page import="java.sql.*" %>
    <%@ page import="org.postgresql.jdbc.*" %>

    <% String url = "jdbc:postgresql://localhost:5432/postgres"; %>
    <% String username = "postgres"; %>
    <% String password = "krishna"; %>

    <% try {
        Class.forName("org.postgresql.Driver");
        Connection conn = DriverManager.getConnection(url, username, password);

        // Use a prepared statement to prevent SQL injection
        String selectSql = "SELECT * FROM userinfo WHERE email = ?";
        PreparedStatement selectPstmt = conn.prepareStatement(selectSql);
        selectPstmt.setString(1, userId);
        ResultSet rs = selectPstmt.executeQuery();

        if (rs.next()) {
            // Get user information
            
            String fname = rs.getString("firstname");
            String lname = rs.getString("lastname");
            String gen = rs.getString("gender");
            String email = rs.getString("email");
            String pass = rs.getString("password");
            String phone = rs.getString("phone");

            // Insert user information into deleteduser table
            String insertSql = "INSERT INTO deleteduser (firstname,lastname,gender, email,password, phone) VALUES (?, ?, ?, ?, ?,?)";
            PreparedStatement insertPstmt = conn.prepareStatement(insertSql);
            insertPstmt.setString(1, fname);
            insertPstmt.setString(2, lname);
            insertPstmt.setString(3, gen);
            insertPstmt.setString(4, email);
            insertPstmt.setString(5, pass);
            insertPstmt.setString(6, phone);
            insertPstmt.executeUpdate();
            insertPstmt.close();

            // Delete user from userinfo table
            String deleteSql = "DELETE FROM userinfo WHERE email = ?";
            PreparedStatement deletePstmt = conn.prepareStatement(deleteSql);
            deletePstmt.setString(1, userId);
            deletePstmt.executeUpdate();
            deletePstmt.close();

            out.println("<p style='color:white;'>User with Email: " + userId + " has been deleted and their information has been saved.</p>");
        } else {
            out.println("<p style='color:white;'>User with ID: " + userId + " not found.</p>");
        }

        selectPstmt.close();
        rs.close();
        conn.close();
        
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error occurred while deleting user.</p>");
    } %>

    <button onclick="window.history.back()">Back</button>
