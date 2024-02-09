<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
<head>
    <title>Report</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    
        <link rel="stylesheet" href="design/report.css">
    
</head>
<body>
<div class="container">
    <h1 style="color:red;"><b>Report</b></h1>
    <hr>

  

<a href="Admin.jsp" class="btn btn-danger">Back</a>

<br>
<br>
<% 
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement pstmt1 = null;
            ResultSet rs = null;
            ResultSet rs1=null;

            try {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

                // Use a prepared statement to prevent SQL injection for file_data table
                String sql = "SELECT file_type,mode,price FROM file_data";
                pstmt = conn.prepareStatement(sql);
               
                rs = pstmt.executeQuery();
                
                int totalUsers=0;
                int totalFiles = 0;
                int encryptedFiles = 0;
                int decryptedFiles = 0;
                int imageFiles=0;
                int audioFiles=0;
                int videoFiles=0;
                int textFiles=0;
                double totalPrice = 0;

                if (rs.next()) {
   
                    do {
                        totalFiles++;
                        String fileMode = rs.getString("mode");
                        if (fileMode.equals("encrypt")) {
                            encryptedFiles++;
                        } else if (fileMode.equals("decrypt")) {
                            decryptedFiles++;
                        }
                        String type =rs.getString("file_type");
                        if(type.equals("image"))
                        		{
                        	imageFiles++;
                        		}
                        else if(type.equals("video"))
                		{
                	   videoFiles++;
                		}
                        else if(type.equals("audio"))
                		{
                	     audioFiles++;
                		}
                        else if(type.equals("text"))
                		{
                	      textFiles++;
                		}
                        	
                        double price = Double.parseDouble(rs.getString("price"));
                        totalPrice += price;
                } while (rs.next()); 
                    
            } else { %>
                    <p><i>No file data found.</i></p>
  <%  }
                
                String sql1="SELECT email FROM userinfo";
                pstmt1=conn.prepareStatement(sql1);
                
               
               rs1=pstmt1.executeQuery();
               if(rs1.next())
               {
            	 
            	  do
            	  {
            		  totalUsers++;
            	  }
            	  while(rs1.next());
               }
               else
               {
            	   %><p>User Data Not Found</p><%
               }
          
    %>
<div class="info-block">
  
  <div class="info-details">
    <h3 class="info-title">Active Users</h3>
    <h4 class="info-number"><b><%=totalUsers %></b></h4>
  </div>
</div>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Total Files</h3>
    <h4 class="info-number"><b><%=totalFiles%></b></h4>
  </div>
</div>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Encrypted Files</h3>
    <h4 class="info-number"><b><%=encryptedFiles%></b></h4>
  </div>
</div>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Decrypted Files</h3>
    <h4 class="info-number"><b><%=decryptedFiles%></b></h4>
  </div>
</div>

<div class="paid-block">
  <div class="paid-title">Total Revenue</div>
  <div class="paid-amount"><b>₹<%=totalPrice %></b></div>
</div>
<hr>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Text Files</h3>
    <h4 class="info-number"><b><%=textFiles%></b></h4>
  </div>
</div>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Image Files</h3>
    <h4 class="info-number"><b><%=imageFiles%></b></h4>
  </div>
</div>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Audio Files</h3>
    <h4 class="info-number"><b><%=audioFiles%></b></h4>
  </div>
</div>

<div class="info-block">
  <div class="info-details">
    <h3 class="info-title">Video Files</h3>
    <h4 class="info-number"><b><%=videoFiles%></b></h4>
  </div>
</div>




    
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
                    if (rs1 != null) {
                        rs1.close();
                    }
                    if (pstmt1 != null) {
                        pstmt1.close();
                    }
                    if (conn != null) {
                        conn.close();
                    }
                }
                catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        
        
            Connection con = null;
            PreparedStatement ps = null;
            PreparedStatement ps1 = null;
            ResultSet r = null;
            ResultSet r1 = null;

            try {
                Class.forName("org.postgresql.Driver");
                con = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

                // Use a prepared statement to prevent SQL injection for file_data table
                String sql = "SELECT firstname,lastname,email from userinfo LIMIT 10";
                ps = con.prepareStatement(sql);
                r = ps.executeQuery();
                %><hr><table border=1>
                <tr>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Encrypted Files</th>
                    <th>Decrypted Files</th>
                    <th>Total Files</th>
                    <th>Amount</th>
                </tr><%

                while (r.next()) {
                    String fname = r.getString("firstname");
                    String lname = r.getString("lastname");
                    String email = r.getString("email");

                    String sql1 = "SELECT price, mode, username from file_data where username=?";
                    ps1 = con.prepareStatement(sql1);
                    ps1.setString(1, email);
                    r1 = ps1.executeQuery();

                    int efile = 0;
                    int dfile = 0;
                    int tfile = 0;
                    double total = 0;
                   
                    while (r1.next()) {
                        tfile++;
                        String mode = r1.getString("mode");
                        if (mode.equals("encrypt")) {
                            efile++;
                        } else if (mode.equals("decrypt")) {
                            dfile++;
                        }
                        double price1 = Double.parseDouble(r1.getString("price"));
                        total += price1;
                    }

                    %>
                   
                        <tr>
                            <td><b><%=fname%></b></td>
                            <td><b><%=lname%></b></td>
                            <td><b><%=email%></b></td>
                            <td><b><%=efile%></b></td>
                            <td><b><%=dfile%></b></td>
                            <td><b><%=tfile%></b></td>
                            <td style="color:green;"><b><%=total%></b></td>
                        </tr>
                   
                    <%
                }
                %></table><%
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                try {
                    if (r != null) {
                        r.close();
                    }
                    if (ps != null) {
                        ps.close();
                    }
                    if (r1 != null) {
                        r1.close();
                    }
                    if (ps1 != null) {
                        ps1.close();
                    }
                    if (con != null) {
                        con.close();
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }

        
        %>


 
  
</div>
</body>
</html>






