package ServletInfo;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.regex.*;

@WebServlet("/RegServ")
public class RegServ extends HttpServlet {
	private static final long serialVersionUID = 12002L;
       
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String uname=request.getParameter("uname");
		String lname=request.getParameter("lname");
		String gender=request.getParameter("gender");
		String uEmail=request.getParameter("email");
		String no=request.getParameter("no");
		 String password=request.getParameter("psw");
		 String password_c=request.getParameter("psw-repeat");
		 String email = "^[a-zA-Z0-9_+&*-]+(?:\\."+
					"[a-zA-Z0-9_+&*-]+)*@" +
					"(?:[a-zA-Z0-9-]+\\.)+[a-z" +
					"A-Z]{2,7}$";
		 
		 Pattern p=Pattern.compile(email);
		 
		 Matcher m=p.matcher(uEmail);
		 
		
		 if(! m.matches())
		 {
			 request.setAttribute("invalidmail","Email is not valid. Please Enter valid email address");
		
		 }
		 else if(!password.equals(password_c))
		 {
			  request.setAttribute("errormsg","Password Does not Match \n Please Enter Correct Password");
	
			
		 }

		 else {
			 Connection conn;
			 PreparedStatement ps=null;
			 ResultSet rs=null;
	
				    try {
						Class.forName("org.postgresql.Driver");
				    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");
				    String sql = "SELECT * FROM userinfo WHERE email=?";
				    ps = conn.prepareStatement(sql);
				    ps.setString(1, uEmail);
				    rs= ps.executeQuery();
				    
				    
				    if (rs.next()) {
	                    request.setAttribute("existuser", "User already exists. Please choose a different email address.");
				    }
				    else
				    {
				    
				    
				    	String s1="INSERT INTO userinfo(firstName,lastName,gender,email,password,phone)values(?,?,?,?,?,?)";
				    	ps=conn.prepareStatement(s1);
				    	ps.setString(1, uname);
				    	ps.setString(2, lname);
				    	ps.setString(3, gender);
				    	ps.setString(4, uEmail);
				    	ps.setString(5, password);
				    	ps.setString(6, no);
				    	ps.executeUpdate();
				    	ps.close();
		    			conn.close();
		    		    rs.close();
				    	response.sendRedirect("Login.jsp");
				    	return;
				    	
				    	  
						    
				    	
				    }
				    }
				    	
				    
				    	catch(SQLException | ClassNotFoundException  e)
				    	{
				    		System.out.println(e.getMessage());
				    	}
				
				    	
			    
			  
			  
				    }
			    RequestDispatcher dispatcher = request.getRequestDispatcher("Registration.jsp");
			    dispatcher.forward(request, response);
			} 
			
		
	}



