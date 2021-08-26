<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> create </h1>

<input type="text" name="userid" id="userid">
<input type="text" name="userpassword" id="userpassword">
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<button onclick="submitEvent()">submit</button>


</body>
<script>
function submitEvent(){
	

	var userid = document.getElementById("userid").value;
	var userpassword = document.getElementById("userpassword").value;
	
	if(userid == ""){
		alert("userid is null");
		return false;
	}
	if(userpassword ==""){
		alert("userpassword is null");
		return false;
	}
	  axios.get('http://localhost:8089/createinsert',{
	        params:{
	        	userid:userid,
	        	userpassword:userpassword,
	        }
	    })
	    .then((res)=>{
	        //if success! //
	        console.log(res);
	      
	    })

	
}



</script>
</html>
