<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>고객등록 신청서</title>
<link href="design.css" rel="stylesheet" type="text/css">

</head>

<body>

  <div class="page_header">
    	<div class="toplogo"><a href="#"><img src="images/top_logo.jpg" width="276" height="40" alt="beautifullife"></a>
      </div>
        <div class="topnav">
        	<ul>
            	<li><a href="#"><img src="images/top_menu1.jpg" width="72" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu2.jpg" width="76" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu3.jpg" width="64" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu4.jpg" width="134" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu5.jpg" width="99" height="24" alt="ArtStory"></a></li>
                <li><a href="#"><img src="images/top_menu6.jpg" width="52" height="24" alt="ArtStory"></a></li>
            </ul>
        </div>
  </div>
     
     <div class="page_subimg">
     	<div class="subimgline"></div>
        <div class="subimg">
        	<div id="apDivSubimg"></div>
       </div>
     </div>

  <div class="page_content">
    	<div class="leftmenu">
   	    	<img src="images/left_title.jpg" width="152" height="24" alt="membership"> 
        	<ul>
            	<li></li>
            	<li><a href="#">회원가입</a></li>
                <li><a href="#">아이디찾기</a></li>
                <li><a href="#">비번찾기</a></li>
                <li><a href="#">마이페이지</a></li>
                <li><a href="#">1:1문의하기</a></li>
                <li><a href="#">질문내역</a></li>
                <li><a href="#">후기내역</a></li>
                <li><a href="#">쿠폰내격</a></li>
                <li><a href="#">적립금내역</a></li>
            </ul>
        
        
        </div>
        <div class="rightcon">
        <% request.setCharacterEncoding("utf-8"); %>
                <img src="images/title1.jpg" width="464" height="58" alt="고객등록">
                <div class="tablestyle">
         <%
         	Connection conn = ConnectionProvider.getConnection();
         	int movieId = Integer.parseInt(request.getParameter("movieId"));
         	Movie movie = null;
         	try {
         		MovieDao dao = new MovieDao();
         		movie = dao.selectById(conn, movieId);
         	}catch(SQLException e){}
         	finally {
         		JdbcUtil.close(conn);
         	}
         %>
         <c:set var="movie" value="<%=movie%>"/>
       
            		<div class="bigposter"><img src="./myimages/${movie.poster}" width="300" height="350"></div>
                  <div class="desc">
                    <form name="frm" method="post">
                    <input type="hidden" name="movieId" value="${movie.movieId}">
                    <p>제목: ${movie.title}</p>
                    <p>제작사:${movie.maker}</p>
                    <p>가격:${movie.price}</p>
                    <p>개봉일:${movie.openDate}</p>
                    <p>수량:
                      <select name="amount" id="amount">
                        <option value="1" selected>1개</option>
                        <option value="2">2개</option>
                        <option value="3">3개</option>
                        <option value="4">4개</option>
                      </select>
                    </p>
                    <p>
                      <input type="button" onclick="purchase(form)" value="구매">
                      <input type="button" onclick="putcart(form)" value="카트담기">
                      <input type="reset" name="cancel" id="cancel" value="취소">
                    </p>
                    </form>
                  </div>
                  <script type="text/javascript">
                  function purchase(frm){
                		var amount = frm.amount.value.trim();
                		var movieId = frm.movieId.value.trim();
                		//location.href='purchase.jsp?bookId='+id+'&amount='+amount;
                		window.open("purchase.jsp?movieId="+movieId+"&amount="+amount,"","width=500, height=300");
                	}
                	function putcart(frm){
                		var amount = frm.amount.value.trim();
                		var movieId = frm.movieId.value.trim(); 
                		window.open("putCart.jsp?movieId="+movieId+"&amount="+amount,"","width=500, height=300");
                	}

                  </script>
                  
                </div>
                    <div class="poster"><img src="./myimages/${movie.poster}" width="200" height="250"></div>
                    <div class="title">${movie.title}</div>
                </div>
                 
  
                </div>
         </div>
    </div>


</body>
</html>
