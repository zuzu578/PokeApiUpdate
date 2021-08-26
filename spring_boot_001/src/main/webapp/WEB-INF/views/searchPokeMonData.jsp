<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KyZXEAg3QhqLMpG8r+8fhAXLRk2vvoC2f3B09zVXn8CA5QIVfZOJ3BCsw2P0p/We"
	crossorigin="anonymous">
<title>포켓몬 검색</title>
</head>
<style>

.search_area {
	width: 1300px;
	margin: 0 auto;
}

.mid_title {
	text-align: center;
	margin-top: 40px;
}

.pokeMonImage {
	text-align: center;
}

.pokeName_title {
	text-align: center;
}

.location_area {
	display: flex;
}

.pokeInfo_data {
	display: flex;
	align-items: center;
	justify-content: center;
}

.p_01 {
	font-weight: bold;
	font-size: 20px;
}

.poke_evole_area {
	display: flex;
}

.parap {
	text-align: center;
}

.main_image img {
	width: 20%;
}

.evolutin_info_title {
	text-align: center;
}

.pok_desc_table {
	display: flex;
}

.N_1 {
	text-align: center;
}

.rec img {
	width: 40%;
}

.rec {
	width: 25%;
}

.container {
	display: flex;
	flex-wrap: wrap;
}

.pageNation_button {
	width: 120px;
	margin: 0 auto;
	margin-top: 20px;
	margin-bottom: 20px;
}

</style>
<body>

	<h1 class="mid_title">
		<div class="main_image">
			<img
				src="https://upload.wikimedia.org/wikipedia/commons/thumb/9/98/International_Pok%C3%A9mon_logo.svg/500px-International_Pok%C3%A9mon_logo.svg.png">
		</div>
	</h1>

	<div class="search_area">
		<div class="input-group mb-3">

			<input type="text" id="pokeMonSearch" class="form-control"
				placeholder="pokeMonName" aria-describedby="basic-addon1">
			<button type="button" @click="search()" class="btn btn-primary">검색</button>
			<button type="button" @click="refresh()" class="btn btn-success">초기화</button>
		</div>
		<h2 style="text-align: center;">recommend!</h2>
		<!--  pageNation을 위한 현재 page Number 정보 ! -->
		<input type="hidden" name="current_page" id="current_page" value='1'>
		<div class="container">

			<div class="rec" v-for="(data, idx) in samplePokeMonName" :key="idx">
				<img
					:src="'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/' + data.id +'.png'">
				{{data.name}}
			</div>
		</div>
		<div class="pageNation_button">
			<nav aria-label="Page navigation example">
				<ul class="pagination">
					<li class="page-item" @click="prev()"><a class="page-link"
						href="#">Previous</a></li>
					<li class="page-item" @click="next()"><a class="page-link"
						href="#">Next</a></li>
				</ul>
			</nav>
		</div>

		<div id="data_Area_OB">
			<h2 style="text-align: center;">검색결과</h2>
			<h2 class="N_1" v-if="is_mythical == true">신화포켓몬</h2>
			<h2 class="N_1" v-if="is_legendary == true">전설의포켓몬</h2>

			<div class="pokeInfo_data">
				<div class="pokeMonImage">

					<img v-bind:src="official_artwork">

					<div class="poke_desc">
						<!--  중복검색으로 인한 데이터 중복 append 방지 -->
						<input type="hidden" id="pokeMonNameCheck" v-model="pokeMonName"
							ref="pokeMonName">
						<h2 class="pokeName_title">
							<img v-bind:src="pokeMonImage"> {{pokeMonName}} #( {{pokeId
							}} )
						</h2>
						<p class="p_01">지니고 있는 아이템 :{{held_items}}</p>
						<p class="p_01">포획률 : {{capture_rate}}</p>
						<p class="p_01">세대 : {{generation}}</p>
						<p class="p_01">기초 친밀도 : {{base_happiness}}</p>
						<p class="p_01">색상 : {{color}}</p>
						<p class="p_01">전설 여부 :{{is_legendary}}</p>
						<p class="p_01">신화포켓몬 여부 :{{is_mythical}}</p>



						<p class="p_01">
							<input type="hidden" id="evolution_chain"
								v-model="evolution_chain" ref="evolution_chain">
						</p>

					</div>
				</div>


				<table class="table table-striped" id="nickname">
					<tbody id="t_01">
						<tr>
							<td><h2>국가별 포켓몬 별칭</h2></td>
						</tr>
						<tr>
							<td></td>

						</tr>
					</tbody>
				</table>


				<table class="table table-striped" id="realName">
					<tbody id="t_02">
						<tr>
							<td><h2>국가별 포켓몬이름</h2></td>
						</tr>
						<tr>
							<td></td>

						</tr>
					</tbody>
				</table>
			</div>


			<h2 class="evolutin_info_title">진화 정보</h2>
			<div class="poke_evole_area">
				<div class="ev_01">
					<img v-bind:src="EvolveChain3">

					<p class="parap">{{beforeEvole}}</p>
				</div>


				<div class="ev_01">
					<img v-bind:src="EvolveChain2">
					<p class="parap">{{nowPokeMon}}</p>
				</div>
				<div class="ev_01">
					<img v-bind:src="EvolveChain1">
					<p class="parap">{{afterEvole}}</p>
				</div>



			</div>
			<div class="pok_desc_table">
				<table class="table table-striped" id="poke_desc">
					<tbody id="t_03">
						<tr>
							<td><h2>도감 설명</h2></td>

						</tr>
						<tr>


						</tr>
					</tbody>
				</table>
				<table class="table table-striped" id="poke_desc2">
					<tbody id="t_04">
						<tr>
							<td><h2>버전</h2></td>

						</tr>
						<tr>


						</tr>
					</tbody>
				</table>
			</div>
			<h2>능력</h2>

			<table class="table table-striped" id=table_pokeinfo>
				<tbody id="t_05">
					<tr>

					</tr>
				</tbody>
			</table>
			<h2>지닌아이템</h2>

			<table class="table table-striped" id=held_items>
				<tbody id="t_06">
					<tr>

					</tr>
				</tbody>
			</table>
			<h2>능력 상세 설명</h2>
			<table class="table table-striped" id=table_pokeinfo_desc>
				<tbody id="t_07">
					<tr>

					</tr>
				</tbody>
			</table>
			<h2>포켓몬 정보</h2>
			<div class="table_items">
				<table class="table table-striped" id="table_pokeinfo">
					<tbody id="t_08">
						<tr>
							<td>타입</td>
							<td>앞모습</td>
							<td>뒷모습</td>
							<td>키</td>
							<td>몸무게</td>
							<td>기초체력</td>
							<td>기본공격력</td>
							<td>기본방어</td>
							<td>기본특수공격력</td>
							<td>기본특수방어력</td>
							<td>기본스피드</td>
							<td>기본경험치</td>

						</tr>

						<tr>
							<td>{{pokeMonType}}</td>
							<td><img v-bind:src="pokeMonImage"></td>
							<td><img v-bind:src="back_default"></td>
							<td>{{height}}</td>
							<td>{{weight}}</td>
							<td>{{baseHp}}</td>
							<td>{{baseAttack}}</td>
							<td>{{baseDefence}}</td>
							<td>{{baseSpecialAttack}}</td>
							<td>{{baseSpecialDefence}}</td>
							<td>{{baseSpeed}}</td>
							<td>{{base_experience}}</td>
						</tr>


					</tbody>
				</table>

			</div>

			<h2>배우는 기술</h2>
			<div class="moves_items">
				<table class="table table-striped" id="moves_table">
					<tbody id="t_09">
						<tr>

						</tr>
						<tr>
							<td></td>
						</tr>


					</tbody>
				</table>


			</div>
			<h2>포켓몬 출몰지역(전설의 포켓몬은 데이터를 가져오지 않을수도있습니다.)</h2>
			<div class="location_area">
				<table class="table table-striped" id="location_area_table">
					<tbody id="t_10">
						<tr>

						</tr>
						<tr>

						</tr>

					</tbody>

				</table>
				<!-- 
  	 <table class="table table-striped" id="location_version_table">
  	<tr> 
  	<td> 게임버전 </td>
  	</tr>
  	<tr>
  
    </tr>
  	
  	
  	
  	</table>
  	 -->


	

		</div>
	</div>
</div>
</body>
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="//code.jquery.com/jquery-3.2.1.min.js"></script>
<script>
const app = new Vue({
    el: '.search_area',
    data:{
    	pokeMonName: '',
    	pokeMonType: '',
    	pokeMonImage:'',
    	height:'',
    	weight:'',
    	baseHp:'',
    	baseAttack:'',
    	baseDefence:'',
    	baseSpecialAttack:'',
    	baseSpecialDefence:'',
    	baseSpeed:'',
    	base_experience:'',
    	back_default:'',
    	official_artwork:'',
    	pokeId : '',
    	moves: '',
    	pokeMonType2:'',
    	abilities : '',
    	location_area:'',
    	base_happiness:'',
    	color:'',
    	evolution_chain:'',
    	evolves_from_species:'',
    	genera:'',
    	generation:'',
    	beforeEvole: '',
    	nowPokeMon:'',
    	afterEvole:'',
    	EvolveChain1:'',
    	EvolveChain2:'',
    	EvolveChain3:'',
    	pokeDesc:'',
    	habitat:'',
    	pokeAllDesc:'',
    	descVersion:'',
    	version:'',
    	effectDesc:'',
    	capture_rate:'',
    	held_items:'',
    	is_legendary:'',
    	is_mythical:'',
    	samplePokeMonName:'',
    	samplePokeMonId:'',
    	defaultPageNum:'',
    	
    	
    	
    	
   
    	
    },
    mounted(){
    	document.getElementById("data_Area_OB").style.display="none";
    	// $("#data_Area_OB").attr('style', "display:'';");
    	// mounted되자마자 포켓몬 샘플 List data 를 가져온다.
    	var pageNum = document.getElementById('current_page').value
    	axios.get('/getPokemonList',{
    		params:{
    			defaultPageNum : pageNum,
    		}
    	})
  	   .then((res)=>{
  		   console.log("전체 포켓몬 샘플갯수 !");
  		   console.log(res.data);
  		   this.samplePokeMonName = res.data.results;
  		   for(var i = 0 ; i < Object.keys(res.data.results).length ; i++){
  			   console.log(res.data.results[i].id);   // 포켓몬 고유번호 
  			   console.log(res.data.results[i].name); // 포켓몬 이름 
  	
  			 //  this.samplePokeMonName = res.data.results[i].name;
  			   this.samplePokeMonId = res.data.results[i].id;
  			  // var img = " <img :src ="'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/' + samplePokeMonId +'.png'">";
  			   // $('#samplePoke').append('<tr><td>' + img + '</tr></td>')
  				// $('#samplePoke').append('<tr><td>' + this.samplePokeMonName+ '</tr></td>')
  			
  			
  		   }
  	   })
    },
    created(){
   
    	
    },
    methods: {
    	// 이전 버튼 클릭시 이전  포켓몬 리스트 보여주기 
    	prev(){
    		alert("이전 추천포켓몬을 보여줍니다");
    		   console.log("이전페이지 클릭 !" );
    		      var pageNum = document.getElementById('current_page').value
    		      var currentPageNum = parseInt(pageNum) -1;
    		       document.getElementById('current_page').value = currentPageNum;
    		      //alert(currentPageNum);
    		      console.log(currentPageNum)
    		      this.defaultPageNum = currentPageNum;
    		      console.log("현재 페이지 ==> " + this.defaultPageNum);
    		      if(this.defaultPageNum <= 0 ){
    		          console.log("이전 데이터가 없습니다.")
    		          // - 값이 된 페이지를 초기 값으로 복원합니다.
    		          this.defaultPageNum = 1;
    		          console.log("페이지값 복원 ====> "+ this.defaultPageNum);
    		          return false;
    		      }
    		       axios.get('/getPokemonList',{
    		        params: {
    		        defaultPageNum : this.defaultPageNum,
    		   
    		        }
    		    }) 
    		    .then((res)=>{
    		        //get Data List 
    		
    		        console.log(res.data);
    		  		   this.samplePokeMonName = res.data.results;
    		  		   for(var i = 0 ; i < Object.keys(res.data.results).length ; i++){
    		  			   console.log(res.data.results[i].id);   // 포켓몬 고유번호 
    		  			   console.log(res.data.results[i].name); // 포켓몬 이름 
    		  	
    		  			 //  this.samplePokeMonName = res.data.results[i].name;
    		  			   this.samplePokeMonId = res.data.results[i].id;
    		  		   }
    		        
    		    })
    	},
    	// 다음버튼 클릭시 다음 페이지 보여주기 
    	next(){
    		alert("다음 추천포켓몬을 보여줍니다.");
    		 console.log("다음페이지 click! ");
    	      var pageNum = document.getElementById('current_page').value
    	      var currentPageNum = parseInt(pageNum) +1;
    	      document.getElementById('current_page').value = currentPageNum;
    	      //alert(currentPageNum);
    	      console.log(currentPageNum)
    	      this.defaultPageNum = currentPageNum;
    	      console.log("현재 페이지 ==> " + this.defaultPageNum);
    	      axios.get('/getPokemonList',{
    	        params: {
    	        defaultPageNum : this.defaultPageNum,
    	        
    	        }
    	    }) 
    	    .then((res)=>{
    	        //get Data List 
    	    	 console.log(res.data);
    	  		   this.samplePokeMonName = res.data.results;
    	  		   for(var i = 0 ; i < Object.keys(res.data.results).length ; i++){
    	  			   console.log(res.data.results[i].id);   // 포켓몬 고유번호 
    	  			   console.log(res.data.results[i].name); // 포켓몬 이름 
    	  	
    	  			 //  this.samplePokeMonName = res.data.results[i].name;
    	  			   this.samplePokeMonId = res.data.results[i].id;
    	  		   }
    	     
    	    })
    	},
    	refresh(){
    		window.location.reload();
    	},
    	search(){
    		// 검색한 포켓몬의 데이터를 가져온다.
    		var pokeMon = document.getElementById("pokeMonSearch").value;
    		var pokeoverlapCheck = document.getElementById("pokeMonNameCheck").value;
    		if(pokeMon == pokeoverlapCheck){
    			alert("중복 검색 방지!");
    			return false;
    		}
    		// $("#비워야할 리스트 상위 요소").empty()
    		//$(".ev_01").empty();
    		$("#t_01").empty();
    		$("#t_02").empty();
    		$("#t_03").empty();
    		$("#t_04").empty();
    		$("#t_05").empty();
    		$("#t_06").empty();
    		$("#t_07").empty();
    		//$("#t_08").empty();
    		$("#t_09").empty();
    		$("#t_10").empty();
    		
    	
    		if(pokeMon == ""){
    			alert("포켓몬을 입력해주세요!")
    			return false;
    		}
    		axios.get('/getPokeMonData',{
    	        params:{
    	        	pokeMon:pokeMon,
    	        }
    	    })
    	    .then((res)=>{
    	        //if success! //
    	    //console.log(res.data);
    	     this.pokeMonType = res.data.types[0].type.name;
    	     //this.pokeMonType2 = res.data.types[1].type.name;
    	     // Object.keys(res.data.held_items).length
    	     for(var i = 0 ; i < Object.keys(res.data.held_items).length; i++){
        	     this.held_items = res.data.held_items[i].item.name;
        	     console.log("지니고 있는 아이템 ");
        	     console.log(res.data.held_items[i].item.name);
        	     $("#held_items").append("<tr><td>"+ this.held_items + "</tr></td>");
    	     }

    	     this.pokeMonImage = res.data.sprites.front_default;
    	     this.pokeMonName = res.data.forms[0].name;
    	     this.weight = res.data.weight;
    	     this.height = res.data.height; 	 
    	     this.back_default = res.data.sprites.back_default;
    	     this.baseHp = res.data.stats[0].base_stat;
    	     this.baseAttack = res.data.stats[1].base_stat;
    	     this.baseDefence = res.data.stats[2].base_stat;
    	     this.baseSpecialAttack = res.data.stats[3].base_stat;
    	     this.baseSpecialDefence = res.data.stats[4].base_stat;
    	     this.baseSpeed = res.data.stats[5].base_stat;
    	     this.base_experience = res.data.base_experience;
    	     this.official_artwork = res.data.sprites.other["official-artwork"].front_default;
    	     this.pokeId = res.data.id;
    	    // this.capture_rate = res.data.capture_rate;
    	    // console.log("포획률 ==> ");
    	   //  console.log(res.data);
    	     
    	     this.abilities = res.data.abilities;
    	    // console.log("포켓몬 능력 정보 !=> " );
    	    // console.log(res.data.abilities);
    	     for(var i = 0 ; i < Object.keys(res.data.abilities).length;i++){
    	    	  this.abilities = res.data.abilities[i].ability.name;
    	    	  this.abilitiesurl = res.data.abilities[i].ability.url;
    	    	  $('#table_pokeinfo').append('<tr><td id="ability">' + res.data.abilities[i].ability.name+'</td></tr>');
    	    	  //$('#table_pokeinfo').append('<tr><td id="ability">' + res.data.abilities[i].ability.url+'</td></tr>');
    	    	  
    	     }
    	    // console.log(Object.keys(res.data.moves).length);
    	     // json object 의 객체 갯수(길이를 구하고싶을때 사용);
    	     //console.log(res.data.moves[1]['move'].name);
    	     for(var i = 0 ; i < Object.keys(res.data.moves).length; i++){
    	    	 this.moves = res.data.moves[i].move.name;
    	    	 //console.log(this.moves);
    	    	 // <td>'+res.data[i].version_details[i].version.name+'</td>
    	    	 $('#moves_table').append('<tr><td>'+res.data.moves[i].move.name+'</td></tr>');
    	     }
    	     
    	     //가져온 해당 포켓몬의 능력에대한 정보를 가져온다.
    	     axios.get(this.abilitiesurl)
    	      .then((res)=>{
    	    	//  console.log("능력에 대한 정보 설명 데이터 ");
    	    	//  console.log(res.data);
    	    	  
    	    	  for(var i = 0 ; i< Object.keys(res.data.flavor_text_entries).length; i++){
    	    	//	  console.log("ff");
    	    		  if(res.data.flavor_text_entries[i].language.name == "ko"){
    	    			  this.effectDesc = res.data.flavor_text_entries[i].flavor_text;
    	    			  //const effect = Array.from(new Set(this.effectDesc));
    	    			 
    	    			
    	    			  $("#table_pokeinfo_desc").append('<tr><td>' +  this.effectDesc  + '</td></tr>');
    	    			  
    	    		  }
    	    		  
    	    	  }
    	    	  
    	      }); 
    	       
    	
    	    
    	 
    	   
    	   
    	    })
    	    // 검색한 해당 포켓몬의 출몰 지역을 게임버전별로 보여준다. 
    	    axios.get('/getPokemonEncounters',{
    	        params:{
    	        	pokeMon:pokeMon,
    	        }
    	    })
    	     .then((res)=>{
    	    	console.log("포켓몬 출몰데이터 get ");
    	    //	console.log(res.data);
    	    //	console.log(res.data.length);
    	    	//console.log(Object.keys(res.data[i]).length);
  
    	    	console.log(res.data);
    	    	for(var i = 0 ; i < res.data.length; i++){
    	    		this.location_area = res.data[i].location_area.name;
    	    		$('#location_area_table').append('<tr><td>' +res.data[i].location_area.name+'</td</tr> ');
    	    		 	    		
    	    	}
    	    	/*
    	    	버전 
    	    	for( var j = 0 ; j <= res.data.length;j++){
    	    		console.log(res.data[j].version_details[0].version.name);
    	    		$('#location_version_table').append('<tr><td>' +res.data[j].version_details[0].version.name+'</td</tr> ');
    	    	}
    	    	*/
    	   
    	       
    	     })
    	     // 검색한 해당포켓몬의 정보를 가져온다 
    	     axios.get('/getPokemonSpecies',{
    	    	 params:{
    	    		 pokeMon:pokeMon,
    	    	 }
    	     })
    	     .then((res)=>{
    	    //	 console.log("검색한 해당포켓몬의 정보를 가져옵니다. ( 진화 , 종 등의 데이터 )")
    	    //	 console.log(res.data);
    	    	 this.base_happiness = res.data.base_happiness;
    	    	 this.color = res.data.color.name;
    	    	 this.evolution_chain = res.data.evolution_chain.url;
    	    	 this.capture_rate = res.data.capture_rate;
    	    	 //this.habitat = res.data.habitat.name;
    	    	// this.evolves_from_species = res.data.evolves_from_species.name;
    	  //  	console.log("pokemonDesc data");
    	    	this.is_legendary = res.data.is_legendary;
    	    	this.is_mythical = res.data.is_mythical;
    	    	
    	   // 	console.log(res.data);
    	    	 for(var i = 0 ; i < Object.keys(res.data.genera).length; i++){
    	    //		 console.log("포켓몬 닉네임 ")
    	   // 		 console.log(res.data.genera[i].genus);
    	    		 $('#nickname').append('<tr><td>' +res.data.genera[i].genus +'</td></tr>')
    	    	 }
    	    	 this.generation = res.data.generation.name;
    	    	 for(var i = 0 ; i < Object.keys(res.data.names).length; i++){
    	    	//	 console.log(res.data.names[i].name)
    	    		 $('#realName').append('<tr><td>' +res.data.names[i].name+'</td></tr>')
    	    		 this.realName = res.data.names[i];
    	    		 
    	    	 }
    	    	 //포켓몬 설명 
    	    	 for( var i = 0 ; i < Object.keys(res.data.flavor_text_entries).length; i ++){
    	    		// console.log("해당포켓몬의 설명 ===> + 포켓몬 설명 + ");
    				// console.log(res.data.flavor_text_entries[i]);
    	    		// 한글설명 data List 를 가져온다.
    	    		 if(res.data.flavor_text_entries[i].language.name == "ko"){
    	    			 //console.log("ko data ");
    	    			 //console.log( flavor_text_entries[i]);
    	    			  this.pokeDesc = res.data.flavor_text_entries[i].flavor_text; // 설명 
    	    			  $('#poke_desc').append('<tr><td>' + res.data.flavor_text_entries[i].flavor_text + '</td></tr>');
							//console.log(res.data.flavor_text_entries[i].language.name); // 설명 언어 
						  this.version = res.data.flavor_text_entries[i].language.name;
						  $('#poke_desc2').append('<tr><td>' + res.data.flavor_text_entries[i].version.name + '</td></tr>');
    	    	    
    	    		 }
    	    		
 	    			
    	    	
    	    	 }
    	    	 
    	    	 
    	    	 // 해당 포켓몬의 진화체인정보를 가져온다.
        	     //var evolution_chain = document.getElementById("evolution_chain").value;

        	     axios.get(this.evolution_chain)
        	     .then((res)=>{
        	    	 console.log("진화체인 data get !" );
        	    	 console.log(res.data.chain);
        	    	 
        	         //console.log(res.data.chain.species.name); // 진화 전 포켓몬 
        	    	 if(res.data.chain.species.name === undefined){
        	        	 return false;
        	        	 //this.beforeEvole ="";
        	         }
        	         this.beforeEvole = res.data.chain.species.name;  
        	         
        	         
        	    	 //console.log(res.data.chain.evolves_to[0].species.name);// 현재 포켓몬 
        	    	 //Object.keys(res.data.chain.evolves_to).length
        	    	 for(var i = 0 ; i < Object.keys(res.data.chain.evolves_to).length;i++){
        	    		// this.nowPokeMon = res.data.chain.evoles_to[i].species.name;
        	    		// console.log("nowPokeMonData =>");
        	    		// console.log(this.nowPokeMon);
        	    		console.log(res.data.chain.evolves_to[i].species.name);
        	    	 }
        	    	 if(res.data.chain.evolves_to[0].species.name === undefined){
        	    		 return false;
        	        	 //this.nowPokeMon ="";
        	         }
        	    	this.nowPokeMon = res.data.chain.evolves_to[0].species.name;
        	    	 
        	    	// console.log(res.data.chain.evolves_to[0].evolves_to[0].species.name);
        	    	if(res.data.chain.evolves_to[0].evolves_to[0].species.name === undefined){
       	    		 return false;
       	        	 //this.afterEvole ="";
       	         }
        	    	 this.afterEvole = res.data.chain.evolves_to[0].evolves_to[0].species.name;
        	    	 
        	    	 // 가져온 진화 체인포켓몬의 이름을 기준으로 해당 포켓몬의이미지 데이터를 가져온다.
        	    	 //1) 진화전 포켓몬 데이터  => 3 
		        	 axios.get('/getPokeMonData',{
		    	        params:{
		    	        	pokeMon:this.beforeEvole,
		    	        }
		    	       })
		    	       .then((res)=>{
		    //	    	   console.log("진화전 데이터 ");
		    //	    	   console.log(res.data.sprites.other["official-artwork"].front_default);
		    	    	   this.EvolveChain3 = res.data.sprites.other["official-artwork"].front_default;
		    	       })
		    	       
		    	        //2) 진화후 포켓몬 데이터  순서 : => 1 
		        	 axios.get('/getPokeMonData',{
		    	        params:{
		    	        	pokeMon:this.afterEvole,
		    	        }
		    	       })
		    	       .then((res)=>{
		    	    //	   console.log("진화후 데이터 ");
		    	    //	   console.log(res.data.sprites.other["official-artwork"].front_default);
		    	    	   this.EvolveChain1 = res.data.sprites.other["official-artwork"].front_default;
		    	       })
		    	       //3) 전 3 포켓몬 데이터 순서 : => 2
		    	       
		    	        axios.get('/getPokeMonData',{
		    	        params:{
		    	        	pokeMon:this.nowPokeMon,
		    	        }
		    	       })
		    	       .then((res)=>{
		    	    //	   console.log("진화후 데이터 ");
		    	   // 	   console.log(res.data.sprites.other["official-artwork"].front_default);
		    	    	   this.EvolveChain2 = res.data.sprites.other["official-artwork"].front_default;
		    	       })
        	    	 
        	    	 
        	     });
    	    	 
    	     })
    	    
    	     
    	    
    	     document.getElementById("data_Area_OB").style.display="block"; 
    	 
    },
    }
});




</script>
</html>