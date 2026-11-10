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
            request.setCharacterEncoding("UTF-8");
         	Connection conn = ConnectionProvider.getConnection();
            String target = request.getParameter("target");
            String keyword = request.getParameter("keyword");
         	List<Movie> list = null;
         	try {
         		MovieDao dao = new MovieDao();
         		if (target == null && keyword !="")
         			list = dao.selectList(conn);
         		else
         			list = dao.selectLike(conn, target, keyword);
         	}catch(SQLException e){}
         %>
         <c:set var="list" value="<%=list%>"/>
         <table width="400" border="1" cellpadding="3" cellspacing="0" id="mylist">
                    <tr>
                      <th scope="col">아이디</th>
                      <th scope="col">영화제목</th>
                      <th scope="col">제작사</th>
                      <th scope="col">가격</th>
                      <th scope="col">개봉일</th>
                      <th scope="col">포스터</th>
                      <th scope="col">수정</th>
                      <th scope="col">삭제</th>
                    </tr>
            <c:forEach var="movie" items="${list}">
                    <tr>
                      <td>${movie.movieId}</td>
                      <td>${movie.title}</td>
                      <td>${movie.maker}</td>
                      <td>${movie.price}</td>
                      <td>${movie.openDate}</td>
                      <td><img src="./myimages/${movie.poster}" width="50" height="70"></td>
                      <td><button value="수정" onclick="location.href='updateForm.jsp?movieId=${movie.movieId}'">수정</button></td>
                      <td><button value="수정" onclick="location.href='delete.jsp?movieId=${movie.movieId}'">삭제</button></td>
                    </tr>
            </c:forEach>
            <tr>
            	<td colspan="8"> <a href = "movieuploadform.jsp">상품 추가하기</a></td>
            </tr>
             <tr>
            	<td colspan="8"> 
            	<form action="" method="post">
            	검색기준 : <select name="target">
            		<option value="title">영화제목</option>
            		<option value="maker">제작사</option>
            		<option value="price">가격</option>
            	</select>
            	검색어: <input type="text" name="keyword" size="10">
            	<input type="submit" value="검색">
            	</form>
            	</td>
            </tr>       
           </table>		
                </div>
         </div>
    </div>


</body>
</html>
