<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Bill</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">

<style>
    table {
        margin: auto;
        item-align:left;
    }

    th {
        text-align: center;
    }

    td {
        text-align: center;
    }

    .left {
        text-align: left;
    }

    .right {
        text-align: right;
    }
    
    /* Apply styles specifically for printing */
    @media print {
        table {
            border-collapse: collapse;
            width: 100%;
            margin: 0;
            font-size: 14px;
            line-height: 1.4;
        }
        
        th, td {
            padding: 8px;
            text-align: center;
            border: 1px solid #ddd;
        }
        
        th {
            background-color: #f2f2f2;
        }
        
        tbody td {
            border-top: none;
        }
        
        tfoot td {
            text-align: right;
        }
    }
</style>

<script type="text/javascript">
    function printBill() {
       // var content = document.getElementById("billTable").outerHTML;
       //var previewWindow = window.open('', 'Media Security - Bill Preview');
       //previewWindow.document.write('<html><head><title>Media Security - Bill Preview</title></head><body>' + content + '</body></html>');
      //previewWindow.document.close();
        window.print();
    }
</script>
</head>
<body>

<%
String username = request.getParameter("uname");
String totalPrice = request.getParameter("tprice");
String totalFiles = request.getParameter("tfiles");

Connection conn = null;
PreparedStatement pstmt = null;
PreparedStatement ps = null;
ResultSet rs = null;
ResultSet rs1 = null;

try {
    Class.forName("org.postgresql.Driver");
    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

    String sql1 = "SELECT * FROM userinfo WHERE email = ?";
    ps = conn.prepareStatement(sql1);
    ps.setString(1, username);
    rs1 = ps.executeQuery();

    if (rs1.next()) {
    	 LocalDate date= LocalDate.now();
%>
<button class="btn btn-primary" onclick="printBill()">Print Bill</button>
<a href="User.jsp" class="btn btn-primary">Back</a>
<div class="print">
<div class="container" >
  <div class="row">
    <div class="col-md-8 col-md-offset-2">
      <div class="panel panel-default">
        <div class="panel-heading">
         
        </div>
        <div class="panel-body">
          <table class="table"  id="billTable">

   <thead>
    <tr>
        <th colspan="3">
            <h1>Media Security by AES</h1>
            <hr>
            <h2>Bill</h2>
        </th>
    </tr>
    <tr>
        <td colspan="3" style="text-align: left; text-size:12px; "><b>
            Name: <%= rs1.getString("firstname") %> <%= rs1.getString("lastname") %><br>
           Email: <%= rs1.getString("email") %><br>
           Date: <%=date %>
          
           </b>
          
        </td>
    </tr>
    <tr>
        <th>File Name</th>
        <th>Type</th>
        <th>Price</th>
    </tr>
</thead>

   
        
          
        
        <tbody>
            <% 
            String sql = "SELECT file_id, file_type, price FROM file_data WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();
            while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString("file_id") %></td>
                <td><%= rs.getString("file_type") %></td>
                <td><%= rs.getString("price") %></td>
            </tr>
            <% } %>
        </tbody>
        <tfoot>
           
<tr>
<td class="right"><b>Total Price</b></td>
<td></td>
<td><b><%= totalPrice %></b></td>
</tr>
</tfoot>
</table>
<div class="text-center">
           
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</div>
 

<%
} else {
out.println("User not found!");
}
} catch (SQLException e) {
out.println("An error occurred while retrieving user information!");
e.printStackTrace();
} catch (ClassNotFoundException e) {
out.println("PostgreSQL JDBC driver not found!");
e.printStackTrace();
} finally {
try {
if (rs1 != null) {
rs1.close();
}
if (ps != null) {
ps.close();
}
if (rs != null) {
rs.close();
}
if (pstmt != null) {
pstmt.close();
}
if (conn != null) {
conn.close();
}
} catch (SQLException e) {
out.println("An error occurred while closing the connection!");
e.printStackTrace();
}
}
%>

</body>
</html>
