<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>도서정보 등록</title>
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
                <img src="../images/inform1.png" width="656" height="122" alt="도서정보 등록" class="titleimg">
                <div class="tablestyle">
                  <form name="fr" onsubmit="return check()" method="post" action="upload.jsp" enctype="multipart/form-data">
                    <table border="0" cellpadding="0" cellspacing="0" id="registerform">
                      <tr>
                        <th><label for="namefield">도서명 *</label></th>
                        <td><input type="text" name="name" id="namefield"></td>
                      </tr>
                      <tr>
                        <th><label for="authorfield">저자 *</label></th>
                        <td><input type="text" name="author" id="authorfield"></td>
                      </tr>
                      <tr>
                        <th><label for="isbnfield">ISBN 번호 *</label></th>
                        <td><input type="text" name="isbn" id="isbnfield"></td>
                      </tr>
                      <tr>
                        <th><label for="publisherfield">출판사 *</label></th>
                        <td><input type="text" name="publisher" id="publisherfield"></td>
                      </tr>
                      <tr>
                        <th><label for="pricefield">가격 (원) *</label></th>
                        <td><input type="text" name="price" id="pricefield"></td>
                      </tr>
                      <tr>
                        <th><label for="imagefield">표지 이미지</label></th>
                        <td><input type="file" name="image" id="imagefield" accept=".jpg,.jpeg,.png,.webp">
                        <div class="help">JPG, PNG, WEBP · 최대 2MB</div></td>
                      </tr>
                      <tr>
                        <td colspan="2" class="btnstyle"><img src="../images/button1.png" width="91" height="44" alt="초기화" onclick="document.fr.reset()"><input type="image" name="sendbtn" id="sendbtn" src="../images/button2.png" width="112" height="44" alt="도서 등록"></td>
                      </tr>
                    </table>
                  </form>
                </div>
         </div>
    </div>
<script type="text/javascript">
function check(){
	var frm = document.fr;
	if (frm.name.value.trim() == "") {
		alert("도서명을 입력해주세요");
		frm.name.focus();
		return false;
	}
	if (frm.author.value.trim() == "") {
		alert("저자를 입력해주세요");
		frm.author.focus();
		return false;
	}
	if (frm.isbn.value.trim() == "") {
		alert("ISBN 번호를 입력해주세요");
		frm.isbn.focus();
		return false;
	}
	if (frm.publisher.value.trim() == "") {
		alert("출판사를 입력해주세요");
		frm.publisher.focus();
		return false;
	}
	if (!/^[0-9]+$/.test(frm.price.value.trim())) {
		alert("가격은 0 이상의 정수로 입력해주세요");
		frm.price.focus();
		return false;
	}
	if (frm.image.value != "") {
		if (!/\.(jpg|jpeg|png|webp)$/i.test(frm.image.value)) {
			alert("이미지는 JPG, PNG, WEBP 파일만 가능합니다");
			frm.image.focus();
			return false;
		}
		if (frm.image.files[0].size > 2*1024*1024) {
			alert("이미지는 최대 2MB까지 가능합니다");
			frm.image.focus();
			return false;
		}
	}
	return true;
}
</script>

</body>
</html>
