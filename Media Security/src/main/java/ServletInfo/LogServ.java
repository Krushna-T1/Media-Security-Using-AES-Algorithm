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

import jakarta.servlet.http.HttpSession;


@WebServlet("/LogServ")
public class LogServ extends HttpServlet {
	private static final long serialVersionUID = 12002L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		
		String email=request.getParameter("email");
		String pass=request.getParameter("psw");
		Connection conn=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		if(email.equals("adminlogin@gmail.com"))
		{
			if( pass.equals("admin@1234"))
			{
		 response.sendRedirect("Admin.jsp");
			}
			else
			{
				request.setAttribute("erroradmin", "Password is not Correct");
				RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
			    dispatcher.forward(request, response);
				
			}
	
		}
		else {
		try {
		Class.forName("org.postgresql.Driver");
		conn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");
		String sql="SELECT password FROM userinfo WHERE email=?";
		ps=conn.prepareStatement(sql);
		ps.setString(1,email);
		rs=ps.executeQuery();
		
		if(!rs.next())
		{
			request.setAttribute("errorlogin", "User Not Exist.Please Choose Correct Email Address");
		
		}
		else 
			{
			String password=rs.getString("password");
			if(!pass.equals(password))
			{
			request.setAttribute("errorpass","Password Not Matched With User Account. Enter Valid Password");
			}
			else
			{
				
				HttpSession session = request.getSession();
				session.setAttribute("email",email);
				response.sendRedirect("User.jsp");
				return;
				
			
			}
		 }
		}
		 
		catch(SQLException |ClassNotFoundException e)
		{
			System.out.println(e.getMessage());
		}
		finally
		{
			try
			{
				if(rs!=null)
				{
					rs.close();
				}
				if(ps!=null)
				{
					ps.close();
				}
				if(conn!=null)
				{
					conn.close();
				}
			}
			catch(SQLException e)
			{
				System.out.println(e.getMessage());
				
			}
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Login.jsp");
	    dispatcher.forward(request, response);
		}
		
	}
}
	
	


