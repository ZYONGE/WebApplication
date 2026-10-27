<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.oreilly.servlet.*"%>
<%@page import="com.oreilly.servlet.multipart.*"%>
<%@page import="java.sql.*,my.util.*,my.dao.*,my.model.*" %>
<%
		MultipartRequest multi = new MultipartRequest(request, application.getRealPath("/myimages"), 2*1024*1024, "utf-8", new DefaultFileRenamePolicy());
    	String name = multi.getParameter("name");
    	String author = multi.getParameter("author");
    	String isbn = multi.getParameter("isbn");
    	String publisher = multi.getParameter("publisher");
    	int price = Integer.parseInt(multi.getParameter("price"));
    	String image = multi.getFilesystemName("image");
    	Book book = new Book(name,author,isbn,publisher,price,image);
    	Connection conn = ConnectionProvider.getConnection();
    	try{
    		BookDao dao = new BookDao();
    		dao.insert(conn, book);
    	}catch(SQLException e) {}
    	response.sendRedirect("list.jsp");
%>
