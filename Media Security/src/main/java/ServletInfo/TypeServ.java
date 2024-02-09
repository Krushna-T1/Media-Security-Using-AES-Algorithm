package ServletInfo;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/TypeServ")
public class TypeServ extends HttpServlet {
	private static final long serialVersionUID = 12002L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	String mode=request.getParameter("mode");
	String file=request.getParameter("file");
	String uname=request.getParameter("username");
	
	request.setAttribute("file", file);
	request.setAttribute("mode",mode);
	request.setAttribute("username", uname);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("file.jsp");
    dispatcher.forward(request, response);
	
	}

}
