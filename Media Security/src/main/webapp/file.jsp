<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="design/index.css">
<title>AES Encrypt/Decrypt</title>
</head>

<body>
    
	<h1>Media Security By AES </h1>
	
    <div>
    
	<form action="InputServ" method="post"  enctype="multipart/form-data">

	<p><%=request.getParameter("mode")%></p>
	<input type="hidden" name="mode" value="<%=request.getParameter("mode")%>">
	<input type="hidden" name="uname" value="<%=request.getParameter("username")%>">
	<input type="hidden" name="file" value="<%=request.getParameter("file")%>">
	
			<input type="password" minlength="8" name="key"  placeholder="password"><br>
        <div class="file-input">
    <%
    String rs=null;
String type = request.getParameter("file");
if (type != null) {
    if (type.equals("text")) {
    	rs="25";
%>
<input type="file" name="ifile" id="ifile"  accept="text/csv,text/html,application/xml,text/plain,application/msword,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
<%
    } else if (type.equals("image")) {
    	rs="50";
%>
    <input type="file" name="ifile" id="ifile" accept="image/*">
<%
    } else if (type.equals("audio")) {
    	rs="50";
%>
    <input type="file"name="ifile" id="ifile" accept="audio/*">
<%
    } else if (type.equals("video")) {
    	rs="100";
%>
    <input type="file" name="ifile" id="ifile" accept="video/*">
<%
    }
}
%>
  <input type=hidden name=price value=<%=rs %>>
    </div>
   
		<input type="submit" value="Pay <%=rs%> & Upload">
	</form>
</div>



</body>
</html>
