<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1> result</h1>

<!-- 기본 친밀도  
${data.base_experience }
-->
<!--  지닌 아이템 
<c:forEach items="${data.held_items}" var="map">
           ${map.item.name}
</c:forEach>
 -->
 <!--  
<c:forEach items="${data}" var="map">
           ${map}
</c:forEach>
-->
 <!-- 
 <c:forEach items="${data.types}" var="map">
 타입 : ${map.type.name }
	${map}
</c:forEach>

 -->
</body>
<script>
console.log('${data}')
//console.log('${data}')
//var list = '${data}';
//var json = JSON.parse('${data}');
var arrayList = new Array('${data}');
//console.log(list);
console.log(arrayList.types);
//console.log(arrayList.types);



</script>
</html>