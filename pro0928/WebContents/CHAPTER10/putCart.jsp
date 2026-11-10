<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*, java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카트담기</title>
</head>
<body>
<%
 	Integer movieCount=(Integer)session.getAttribute("movieCount");
	if(movieCount==null) {
  		movieCount = new Integer(0);
 	}     
 	String movieId = request.getParameter("movieId");
 	int amount = Integer.parseInt(request.getParameter("amount"));
 	String loginId = (String)session.getAttribute("LOGIN");
 
 	if(movieId != null) {
 		Cart cart = new Cart(loginId, Integer.parseInt(movieId), amount); 
      	movieCount = new Integer(movieCount.intValue() +1);
    	session.setAttribute("movie"+movieCount, cart);
    	session.setAttribute("movieCount", movieCount);   
  }
  
%>   
<b><center> 당신이 지금까지 선택한 책들의 목록입니다</center></b>
<br><br>
<hr><br><br>
<table border=1 style="width: 300px">
<tr>
	<th>아이디</th><th>이미지</th><th>수량</th>
</tr>
<%   
   	Movie movie = null;
	Cart cart = null;
	Connection conn = ConnectionProvider.getConnection();
	try{
		MovieDao dao = new MovieDao();
   		for(int i=1; i<= movieCount.intValue(); i++) {
     		cart = (Cart)session.getAttribute("movie" + i);
     		movie = dao.selectById(conn, cart.getMovieId());
%>
	<c:set var= "movie" value="<%=movie%>"/>
	<tr>
		<td>${movie.movieId}</td>
		<td><img src="./myimages/${movie.poster}" width="50" height="60"></td>
		<td><%= cart.getAmount() %></td>
	</tr>
<%
   	}
   		
	} catch(SQLException e){}
	finally{
		JdbcUtil.close(conn);
	}
%>
</table>
<hr>
<a href= "cart.jsp"> 처음으로 돌아가기 </a>&nbsp;  
<a href= "cartdelete.jsp"> 카트 비우기 </a>
<input type="button" value="구매하기" onclick="purchase()">
<br><br>
<script>
function purchase() {
	var input = confirm('구매하시겠습니까?');
	if (input) {
		window.open("cartpurchase.jsp","구매");
	}
}
</script>

</body>
</html>