<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>1:1문의하기</title>
<link href="qnadesign.css" rel="stylesheet" type="text/css">

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
            	<li><a href="#">고객등록</a></li>
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
                <img src="images/title2.jpg" width="464" height="58" alt="고객등록">
                <div class="tablestyle">
                  <form action="movieupload.jsp" method="post" enctype="multipart/form-data" name="form1">
                    <table width="680" border="0" cellpadding="0" cellspacing="0" id="registerform">
                      <tr>
                        <th><label for="titlefield">* 제 목</label></th>
                        <td>
                        <input name="title" type="text" id="titlefield" size="70"></td>
                      </tr>
                      <tr>
                        <th><label for="namefield">* 제작사</label></th>
                        <td>
                        <input name="maker" type="text" id="namefield"></td>
                      </tr>
                      <tr>
                        <th><label for="memo">* 가격</label></th>
                        <td><input type="text" name="price" id="price"></td>
                      </tr>
                      <tr>
                        <th><label for="filefield">* 포스터</label></th>
                        <td><input type="file" name="poster" id="filefield"></td>
                      </tr>
                      <tr>
                        <td height="30" colspan="2" align="center" class="btnstyle"><input type="submit" name="ok" id="ok" value="입력">
                        <input type="reset" name="cancel" id="cancel" value="취소"></td>
                      </tr>
                    </table>
                  </form>
                </div>
         </div>
    </div>


</body>
</html>
