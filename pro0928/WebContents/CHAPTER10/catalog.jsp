<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.io.*,java.sql.*,my.util.*,my.dao.*,my.model.*, java.util.*" %>
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
        <% request.setCharacterEncoding("utf-8"); 
        	String loginId = (String)session.getAttribute("LOGIN");
        %>
                <img src="images/title1.jpg" width="464" height="58" alt="고객등록">
                <div class="tablestyle">
                <div id="grreting"><%= loginId %>님 안녕하세요.</div>
        <%
           Connection conn = ConnectionProvider.getConnection();
           List<Movie> list = null;
           String target = request.getParameter("target");
           String direct = request.getParameter("direct");
           try {
              MovieDao dao = new MovieDao();
              if (target == null)
              	list= dao.selectList(conn);
              else
            	 list = dao.selectOrder(conn, target, direct);
           }catch(SQLException e){}
        %>        
        <c:set var="list" value="<%=list %>"/>
        
        <div id="orderview">
        		<form action="" method="post">
        		    정렬 기준:
                    <label for="target"></label>
                    <select name="target" id="target">
                    	<option value="freq">선호도</option>
                    	<option value="title">제목</option>
                    	<option value="maker">제작사</option>
                    	<option value="price">가격</option>
                    	<option value="openDate">개봉일</option>
                    </select>
                    정렬 순서:
                    <label for="direct"></label>
                    <select name="direct" id="direct">
                    	<option value="desc">내림차순</option>
                    	<option value="asc">오름차순</option>
                    </select>
                    <input type="submit" name="btn" id="btn" value="보기">
               </form>
        </div>
        <c:forEach var="movie" items="${list}">
                    <div class="catalogitem">
                    <div class="poster">
                        <a href="detail.jsp?movieId=${movie.movieId}"><img src="./myimages/${movie.poster}" width="200" height="250"></a></div>
                      <div class="title">${movie.title}</div>
                  </div>       
             </c:forEach>                  
                </div>
         </div>
    </div>


</body>
</html>
