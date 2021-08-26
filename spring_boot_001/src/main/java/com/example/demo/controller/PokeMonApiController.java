package com.example.demo.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonParseException;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

import me.sargunvohra.lib.pokekotlin.client.PokeApi;
import me.sargunvohra.lib.pokekotlin.client.PokeApiClient;
import me.sargunvohra.lib.pokekotlin.model.ApiResourceList;
import me.sargunvohra.lib.pokekotlin.model.NamedApiResourceList;
import me.sargunvohra.lib.pokekotlin.model.PokemonSpecies;

@org.springframework.stereotype.Controller
public class PokeMonApiController {
	private PokeApi pokeApi;
	PokeMonApiController(){
		pokeApi = new PokeApiClient();
	}
	
	/*
	 * @desc : 포켓몬 정보를 가져옵니다.
	 * @url : https://pokeapi.co/api/v2/pokemon/{id or name}/ 
	 * @params : id , name
	 * 
	 */
	@RequestMapping("/searchPokeMonData")
	public String searchPokeMonData(HttpServletRequest req, Model model) {
		
		return "searchPokeMonData";
	}
	@RequestMapping("/searchJsp")
	public String searchJsp(HttpServletRequest req, Model model) {
		
		return "searchJsp";
	}
	
	
	
	/*
	 * @desc 포켓몬 데이터 정보를 kotlin code 로 return 한다 
	 * PokeApi class 
	 * 
	 */
	@RequestMapping("/getBerryList")
	@ResponseBody
	public NamedApiResourceList getBerryList(HttpServletRequest req, Model model) {
		System.out.println("포켓몬 열매리스트 데이터를 가져온다.");
	        NamedApiResourceList berryList = pokeApi.getBerryList(1,1000);
	    
		

		return berryList;
	}
	@RequestMapping("/getVersionList")
	@ResponseBody
	public NamedApiResourceList getVersionList(HttpServletRequest req, Model model) {
		// 게임 버전 리스트를 가져온다.
		NamedApiResourceList versionList = pokeApi.getVersionList(1,1000);
		
		return versionList;
	}
	@RequestMapping("/getItemList")
	@ResponseBody
	public NamedApiResourceList getItemList(HttpServletRequest req ,Model model) {
		NamedApiResourceList getItemList = pokeApi.getItemList(1,1000);
		//model.addAttribute("getItemList", getItemList);
		
		return getItemList;
		
	}
	@RequestMapping("/getPokemonList")
	@ResponseBody
	public NamedApiResourceList getPokemonList(HttpServletRequest req ) {
		String defaultPageNum = req.getParameter("defaultPageNum");
		System.out.println("defaultPageNum ===> " + defaultPageNum);
		
		int defaultPage = Integer.parseInt(defaultPageNum);
		
		NamedApiResourceList pokeMoneList = pokeApi.getPokemonList(defaultPage,16);
		
		return pokeMoneList;
	}
	@GetMapping("/getPokeMonDataJsp")
	public String getPokeMonDataJsp(HttpServletRequest req ,Model model) throws ParseException, IOException  {
	
		  System.out.println("getUserGameNowInfo!");
		  BufferedReader br = null;	
		  String pokeMon = req.getParameter("pokeMon");
		 
		
		  String urlstr = "https://pokeapi.co/api/v2/pokemon/"+pokeMon;

			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			
			urlconnection.setRequestMethod("GET");
			
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8")); 
			String result = "";
			String line;
			while((line = br.readLine()) != null) { 
				result = result + line;
			}
			
			JSONParser parser = new JSONParser();
			Object object = parser.parse(result.toString()); 
			JSONObject json = (JSONObject) object;
			
			getMapFromJsonObject(json);
			
			model.addAttribute("data", getMapFromJsonObject(json));
			//ModelMap model = mav.getModelMap();
			//model.addAttribute("paramInfo", getMapFromJsonObject(json));

			return "returnResultPage" ;
		
		
	}
	@GetMapping("/getPokeMonData")
	@ResponseBody
	public Map<String, Object> getUserGameNowInfo(HttpServletRequest req , Model model) throws ParseException, IOException  {
	
		  System.out.println("getUserGameNowInfo!");
		  BufferedReader br = null;	
		  String pokeMon = req.getParameter("pokeMon");
		 
		
		  String urlstr = "https://pokeapi.co/api/v2/pokemon/"+pokeMon;

			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			
			urlconnection.setRequestMethod("GET");
			
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8")); 
			String result = "";
			String line;
			while((line = br.readLine()) != null) { 
				result = result + line;
			}
			
			JSONParser parser = new JSONParser();
			Object object = parser.parse(result.toString()); 
			JSONObject json = (JSONObject) object;
			System.out.println(json);
			return getMapFromJsonObject(json);
		
		
	}
	/*
	 * @desc : 해당 포켓몬의 출몰지역데이터를 게임 버전 별로 가져옵니다. 
	 * @url :  http://localhost:8088/getPokemonEncounters
	 * @params : pokeMon
	 * 
	 */
	@RequestMapping("/getPokemonEncounters")
	@ResponseBody
	public List<?> getPokemonEncounters(HttpServletRequest req , Model model) throws IOException, ParseException {
		System.out.println("getPokemonEncounters!");
		
	
		
		  BufferedReader br = null;	
		  			String pokeMon = req.getParameter("pokeMon");
					System.out.println("해당 포켓몬의 출몰지역데이터를 가져옵니다.");
					String urlstr = "https://pokeapi.co/api/v2/pokemon/"+pokeMon+"/encounters";
					URL url = new URL(urlstr);
					
					HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
					urlconnection.setRequestMethod("GET");
					
					br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8")); // �뿬湲곗뿉 臾몄옄�뿴�쓣 諛쏆븘���씪.
					String result = "";
					String line;
					while((line = br.readLine()) != null) { 
						result = result + line;
					}
					//json Array 로 return 
					JsonParser jsonParser = new JsonParser();
					JsonArray k = (JsonArray) jsonParser.parse(result);
					System.out.println("===========>" + k);
					Gson gson = new Gson();
					// 제네릭이라는 것 자체가 컴파일이 되고 나면 타입 소거가 되기 때문에 원래의 타입을 알 수 없게 되어 버린다.
					// 때문에 해당 제네릭의 타입을 유추한다 
					Type type = new TypeToken<List<Object>>(){}.getType();
				    List<Object> getPokemonEncounters = gson.fromJson(k, type);
				    
				    //model.addAttribute("championMastery",championMastery);
				    return getPokemonEncounters;
		}
	
	/*
	 * @desc : 해당포켓몬의 설명정보를 가져옵니다. 
	 * @url :  http://localhost:8088/getPokemonSpecies
	 * @params : pokeMon
	 * 
	 */
	@RequestMapping("/getPokemonSpecies")
	@ResponseBody
	public Map<String, Object> getPokemonSpecies(HttpServletRequest req , Model model) throws IOException, ParseException {
		 System.out.println("getPokeMonSpecies!");
		  BufferedReader br = null;	
		  String pokeMon = req.getParameter("pokeMon");
		 
		
		  String urlstr = "https://pokeapi.co/api/v2/pokemon-species/"+pokeMon;

			URL url = new URL(urlstr);
			HttpURLConnection urlconnection = (HttpURLConnection) url.openConnection();
			
			urlconnection.setRequestMethod("GET");
			
			br = new BufferedReader(new InputStreamReader(urlconnection.getInputStream(),"UTF-8")); 
			String result = "";
			String line;
			while((line = br.readLine()) != null) { 
				result = result + line;
			}
			
			JSONParser parser = new JSONParser();
			Object object = parser.parse(result.toString()); 
			JSONObject json = (JSONObject) object;
			System.out.println(json);
			return getMapFromJsonObject(json);
		}
		public Map<String , Object > getMapFromJsonObject(JSONObject jsonObj){
			Map<String , Object >map = null;
			try {
				map = new ObjectMapper().readValue(jsonObj.toJSONString(),Map.class);
				System.out.println("map data ===> " + map );
				
			}catch(JsonParseException e) {
				
			}catch(JsonMappingException e) {
				
			}catch(IOException e) {
				
			}
			return map;
		
		}
		}
