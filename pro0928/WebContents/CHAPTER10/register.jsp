<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
                <img src="images/title1.jpg" width="464" height="58" alt="고객등록">
                <div class="tablestyle">
                  <form name="fr" onsubmit="return check() &&checkForm(form)" method="post" action="result.jsp">
                    <table width="680" border="0" cellpadding="0" cellspacing="0" id="registerform">
                      <tr>
                        <th><label for="idfield">*  아이디</label></th>
                        <td><input type="text" name="userId" id="idfield">
                        <input type="button" value="중복확인" class="dup" onclick="winopen()">
                        </td>
                      </tr>
                      <tr>
                        <th><label for="pwfield">* 비밀번호</label></th>
                        <td><input type="password" name="password" id="pwfield"></td>
                      </tr>
                      <tr>
                        <th><label for="pwfield">* 비밀번호 체크</label></th>
                        <td><input type="password" name="password2" id="pwfield"></td>
                      </tr>
                      <tr>
                        <th><label for="pwfield">* 이름</label></th>
                        <td><input type="text" name="name" id="pwfield"></td>
                      </tr>
                      <tr>
                        <td height="30" colspan="2" align="center" class="btnstyle"><input type="image" name="sendbtn" id="sendbtn" src="images/btnimg.jpg"></td>
                      </tr>
                    </table>
                  </form>
                </div>
         </div>
    </div>
<script type="text/javascript">
function check(){ 
	//아이디가 입력이 안되어있을 경우 아이디입력하라는 메세지 출력
	if(document.fr.userId.value == "" || document.fr.userId.value.length < 0){ 
		alert("아이디를 입력해주세요")
		history.back()
		document.fr.userId.focus();
		return false;
	}
	return true;
}
function checkPasswordPattern(str) {
    var pattern1 = /[0-9]/;           // 숫자
    var pattern2 = /[a-zA-Z]/;        // 문자
    var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/; // 특수문자
    if (!pattern1.test(str) || !pattern2.test(str) || !pattern3.test(str) || str.length < 8) {
        alert("비밀번호는 8자리 이상, 문자·숫자·특수문자를 모두 포함해야 합니다.");
        return false;
    } else {
        return true;
    }
}

function checkForm(frm) {
    var pw = frm.password.value.trim();
    var pw2 = frm.password2.value.trim();

    if (!checkPasswordPattern(pw)) {
        frm.password.focus();
        return false;
    }

    if (pw != pw2) {
        alert("비밀번호가 일치하지 않습니다.");
        frm.password2.focus();
        return false;
    }

    alert("회원가입이 완료되었습니다!");
    frm.submit();
}


function winopen(){
	//새창을 열어서 페이지를 오픈 후 -> 회원아이디정보를 가지고 중복체크
	//1. 아이디가 없으면 알림창과 진행x
	if(document.fr.userId.value =="" || document.fr.userId.value.length < 0){
		alert("아이디를 먼저 입력해주세요")
		document.fr.userId.focus();
	}else{
		//2. 회원정보아이디를 가지고 있는 지 체크하려면 DB에 접근해야한다.
		//자바스크립트로 어떻게 DB에 접근할까? => 파라미터로 id값을 가져가서 jsp페이지에서 진행하면 된다.
		window.open("joinIdCheck.jsp?userId="+document.fr.userId.value,"","width=500, height=300");
	}
}
</script>

</body>
</html>
