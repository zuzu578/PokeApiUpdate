<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We" crossorigin="anonymous">
<title>포켓몬 검색 jsp</title>
</head>
<style>
.search_bar{
	width:800px;
	margin:0 auto;

}
.image_banner{

	text-align:center;
}

</style>
<body>
<div class="image_banner">
<img src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/500px-International_Pok%C3%A9mon_logo.svg.png">
</div>
<div class="search_bar">
<form action="/getPokeMonDataJsp" method="get">
<div class="input-group mb-3">

  <input type="text" class="form-control" id="pokeMon" name="pokeMon" placeholder="pokeMonName" aria-label="Username" aria-describedby="basic-addon1">

</div>
</form>
</div>



</body>

<script>


</script>
</html>