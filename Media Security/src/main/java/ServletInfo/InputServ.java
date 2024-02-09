package ServletInfo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import jakarta.servlet.RequestDispatcher;
import CryptoException.CryptoException;
import Main.AES;

@WebServlet("/InputServ")
@MultipartConfig
public class InputServ extends HttpServlet {
	private static final long serialVersionUID = 12002L;
	
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		String mode=request.getParameter("mode");
		String key =request.getParameter("key");
		String uname=request.getParameter("uname");
		String FileType=request.getParameter("file");
		
		String price=request.getParameter("price");
		
		  Part filePart = request.getPart("ifile");
	       
		  
		  String fullName = null;
		  String contentDispositionHeader = filePart.getHeader("content-disposition");
	         for (String content : contentDispositionHeader.split(";")) {
	             if (content.trim().startsWith("filename")) {
	                 fullName= content.substring(content.indexOf('=') + 1).trim().replace("\"", "");
	             }
	         }
	         
	       
	
		
		 
		 
		 
		 System.out.println(mode);
		System.out.println(key);
		System.out.println(filePart);
		System.out.println(uname);
		System.out.println(FileType);
		
		
		if (key == null) {
	        request.setAttribute("message", "!!!Key and input file cannot be empty");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("Return.jsp");
	        dispatcher.forward(request, response);
       
	        return;
	    }
		else if (key.isEmpty()) {
	        request.setAttribute("message", "!!!Key and input file cannot be empty");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("Return.jsp");
	        dispatcher.forward(request, response);
       
	        return;
	    }
		else if (filePart.getSize()==0) {
	        request.setAttribute("message", "!!!Key and input file cannot be empty");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("Return.jsp");
	        dispatcher.forward(request, response);
       
	        return;
	    }
		else {
		byte[] keyByte = null;
		MessageDigest messagedigest;
		try
		{
			messagedigest=MessageDigest.getInstance("SHA256");
			keyByte =messagedigest.digest(key.getBytes(StandardCharsets.UTF_8));
		}
		catch(NoSuchAlgorithmException e)
		{
			e.printStackTrace();
		}
		
		
		
       

          request.setAttribute("status",mode);
          request.setAttribute("ftype",FileType);
          
		
		
		String file= fullName;
		
		String filename=file.substring(0,file.lastIndexOf("."));
		request.setAttribute("fileName", filename);
         
         String fileExtension = file.substring(file.lastIndexOf(".")+1).trim();
         request.setAttribute("Extension", fileExtension);
         
         
		
		try
		{
			if(mode.equals("encrypt"))
			{
				String full=filename+"encrypt."+fileExtension;
				AES.encrypt(keyByte, filePart,mode,key,FileType,uname,full,price);
				
				request.setAttribute("message", "File encrypted Sucessfully");
			}
			else if(mode.equals("decrypt"))
			{
				String full=filename+"decrypt"+fileExtension;
				AES.decrypt(keyByte, filePart,mode,key,FileType,uname,full,price);
				request.setAttribute("message", "File Decrypted Sucessfully");

			}
			else
			{
				request.setAttribute("message", "Invalid Mode"+mode);
		 }
		}
		catch(CryptoException ex)
		{
			request.setAttribute("message",  ex.getMessage());
		}
      }
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("Details.jsp");
		dispatcher.forward(request, response);
	}
  }
