package Main;

import java.io.ByteArrayOutputStream;

import java.io.IOException;
import java.io.InputStream;
import java.security.InvalidKeyException;
import java.security.Key;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.SecretKeySpec;

import CryptoException.CryptoException;
import jakarta.servlet.http.Part;



public class AES {
	public static final String ALGORITHM = "AES";
	public static final String TRANSFORM="AES/ECB/PKCS5Padding";
	public static void encrypt(byte[] keyByte,Part filePart,String mode,String password,String Ftype,String uname,String full, String price)throws CryptoException
	{
	
	
		doCrypto(Cipher.ENCRYPT_MODE,keyByte,filePart,mode,password,Ftype,uname, full,price);
			
	}
	public static void decrypt(byte[] keyByte,Part filePart,String mode,String password,String Ftype,String uname, String full,String price)throws CryptoException
	{
		doCrypto(Cipher.DECRYPT_MODE,keyByte,filePart,mode,password,Ftype,uname,full,price);
	}
	public static void doCrypto(int cipherMode, byte[] keyByte, Part filePart, String mode, String password, String Ftype, String uname,String full,String price) throws CryptoException {
	    try {
	    	
	        
	        Key secretKey = new SecretKeySpec(keyByte, ALGORITHM);
	        Cipher cipher = Cipher.getInstance(TRANSFORM);
	        cipher.init(cipherMode, secretKey);
	        
	        InputStream inputstream = filePart.getInputStream();
	        ByteArrayOutputStream buffer = new ByteArrayOutputStream();
	        byte[] data = new byte[1024];
	        int length;

	        while ((length = inputstream.read(data, 0, data.length)) != -1) {
	            buffer.write(data, 0, length);
	        }
	        byte[] inputBytes = buffer.toByteArray();
	        byte[] outputBytes = cipher.doFinal(inputBytes);
	        
 
	        
	       
	        
	        
	        
	        ImageStore.StoreImage(outputBytes, mode, password, Ftype, uname,full,price);
	        Info.getInfo(outputBytes);
	        
	        inputstream.close();
	        
	    } catch (NoSuchPaddingException | NoSuchAlgorithmException | InvalidKeyException | BadPaddingException | IllegalBlockSizeException | IOException ex) {
	        throw new CryptoException("Error encrypting/decrypting file", ex);
	    } catch (IllegalArgumentException ex) {
	        throw new CryptoException("Invalid parameter: " + ex.getMessage(), ex);
	    }
	}

	
	
	public class ImageStore
	{
		public static String filename;
		
		public static void StoreImage(byte[] outputBytes ,String mode,String password,String Ftype,String uname,String full,String price)
		{
			 filename=full;
		  if(outputBytes==null)
		  {
			  System.out.println("outputByte is null");
			  return;
		  }
		  else {
			Connection conn=null;
			PreparedStatement ps=null;
			
			
			
			  try {
				    Class.forName("org.postgresql.Driver");
				    conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "krishna");

				    String sql = "INSERT INTO file_data (file_id, file,mode,password,file_type,username,price) values (?, ?, ?, ?, ?, ?, ?)";
				    ps = conn.prepareStatement(sql);
				    ps.setString(1,full);
				    ps.setBytes(2, outputBytes);
				    ps.setString(3,mode);
				    ps.setString(4,password);
				    ps.setString(5,Ftype);
				    ps.setString(6,uname);
				    ps.setString(7, price);
				    ps.executeUpdate();

				    System.out.println("Image stored with ID: " +full);
				  } 
			catch(SQLException | ClassNotFoundException e)
			{
				System.out.println(e.getMessage());
			}
			finally
			{
				try
				{
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
		}
		}
		public static String getID()
		{
			return filename;
		}
		
	}
	public class Info
	{
		
		public static byte[] file;
		byte[] out;
		public static void getInfo(byte[] out)
		{
			
			file=out;
		}
		
		public static String size()
		{
			long size=file.length;
			float kb=size/1024;
			float mb=size/(1024*1024);
			if(mb<1)
			{
				String KB1=String.format("%.0f",kb);
				String KB=KB1+"KB";
				return KB;
			}
			else if(mb<1 && kb<1)
			{
			  String byte1=Long.toString(size);
			  String bytes= byte1+"Bytes";
		  return bytes;
		}
			else
			{
				String MB1=String.format("%.2f", mb);
				String MB=MB1+"MB";
				return MB;
			}
			
			
		}
		
	}

}
