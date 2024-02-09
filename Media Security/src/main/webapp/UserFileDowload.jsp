<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.ByteArrayOutputStream"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.io.OutputStream"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="Main.AES" %>
<p>${message}</p>

<%
Connection conn = null;
PreparedStatement ps = null;
ResultSet rs = null;
String id =request.getParameter("fileID");
String ext;
try {
    Class.forName("org.postgresql.Driver");
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

    String sql = "SELECT file FROM file_data WHERE file_id = ?";
    ps = conn.prepareStatement(sql);
    ps.setString(1, id);
    rs = ps.executeQuery();

    if (rs.next()) {
        byte[] imageBytes = rs.getBytes("file");
        String type=rs.getString("file_type");
        
       if(type.equals("image"))
       {
    	    ext="jpg";
       }
        if(type.equals("text"))
       {
    	    ext="txt";
       }
      if(type.equals("video"))
       {
    	    ext="MP4";
       }
       if(type.equals("audio"))
       {
    	    ext="MP3";
       }

        response.setContentType("application/octet-stream");
        response.setContentLength(imageBytes.length);
      

        response.setHeader("Content-Disposition", "attachment; filename=\"" + rs.getString("file_id") + "." + ext + "\"");
        OutputStream os = response.getOutputStream();
        os.write(imageBytes);
        os.flush();
    } else {
        out.println("File not found with ID: " + id);
    }
} catch (Exception e) {
    out.println(e.getMessage());
} finally {
    try {
        if(rs != null){
            rs.close();
        }
        if(ps != null){
            ps.close();
        }
        if(conn != null){
            conn.close();
        }
    } catch (SQLException e) {
        out.println(e.getMessage());
    }
}
%>
>
