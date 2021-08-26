<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1> file upload sample</h1>
	<form method="POST" action="uploadFile" enctype="multipart/form-data">    
	<input type="file" name="uploadFile">
	 <button type="submit">파일 업로드! </button>
	 
	 </form>

</body>
</html>