<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.sql.*,my.util.*,my.dao.*,my.model.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>도서 목록</title>
<link href="bookdesign.css" rel="stylesheet" type="text/css">

</head>

<body>

  <div class="page_header"><img src="../images/head.png" width="1200" height="192" alt="책으로 채우는 나의 서재"></div>

  <div class="page_content">
    	<div class="leftmenu">
   	    	<img src="../images/left.png" width="240" height="558" alt="도서 메뉴" usemap="#leftmap">
   	    	<map name="leftmap">
   	    		<area shape="rect" coords="19,27,217,79" href="input.jsp" alt="도서 등록">
   	    		<area shape="rect" coords="19,97,217,131" href="list.jsp" alt="도서 목록">
   	    	</map>
        </div>
        <div class="rightcon">
                <img src="../images/inform2.png" width="880" height="193" alt="도서 목록" class="titleimg">
                <div class="tablestyle">
         <%
         	Connection conn = ConnectionProvider.getConnection();
         	List<Book> list = null;
         	try {
         		BookDao dao = new BookDao();
         		list = dao.selectList(conn);
         	}catch(SQLException e){}
         %>
         <c:set var="list" value="<%=list%>"/>
         <table border="0" cellpadding="0" cellspacing="0" id="mylist">
                    <tr>
                      <th scope="col">아이디</th>
                      <th scope="col">도서명</th>
                      <th scope="col">저자</th>
                      <th scope="col">ISBN 번호</th>
                      <th scope="col">출판사</th>
                      <th scope="col">가격</th>
                      <th scope="col">이미지</th>
                    </tr>
            <c:forEach var="book" items="${list}">
                    <tr>
                      <td>${book.bookId}</td>
                      <td>${book.name}</td>
                      <td>${book.author}</td>
                      <td>${book.isbn}</td>
                      <td>${book.publisher}</td>
                      <td><fmt:formatNumber value="${book.price}" pattern="#,##0"/>원</td>
                      <td><c:if test="${!empty book.image}"><img src="../myimages/${book.image}" width="44" height="66"></c:if></td>
                    </tr>
            </c:forEach>
           </table>
                </div>
         </div>
    </div>
</body>
</html>
