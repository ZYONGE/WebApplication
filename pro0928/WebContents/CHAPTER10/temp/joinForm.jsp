<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<article>
<h1>Join Us</h1>
<form action="joinPro.jsp" method="post" id="join" name="fr" onsubmit="return check();">
<!-- 필수입력사항 -->
<fieldset>
<legend>필수입력사항</legend>
	<label>아이디</label>
	<input type="text" name="id" class="id">
	<input type="button" value="중복확인" class="dup" onclick="winopen()"><br>
	<label>비밀번호</label>
	<input type="password" name="pw" placeholder="영문숫자조합 4자리이상" required><br>
	<label>비밀번호확인</label>
	<input type="password" name="pass2" required><br>
	<label>이름</label>
	<input type="text" name="name" required><br>
	<label>이메일</label>
	<input type="email" name="email" placeholder="예시 : funweb@funweb.com (@포함기입)" required><br>
	<label>생년월일</label>
	<input type="text" name="birth"  placeholder="예시 : 801231 (6자리)" maxlength="6" required><br>
	<label>성별</label>
	<input type="radio" name="gender" value="f">여	
	<input type="radio" name="gender" value="m">남<br>
</fieldset>

<!-- 선택입력사항 -->

<div class="clear"></div>
<div id="buttons">
<input type="submit" value="회원가입" class="submit">
<input type="reset" value="초기화" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>


<!-- 유효성체크 : 데이터 빈공백체크(id와 성별) -->
<script type="text/javascript">
function check(){ 
	//아이디가 입력이 안되어있을 경우 아이디입력하라는 메세지 출력
	if(document.fr.id.value == "" || document.fr.id.value.length < 0){ 
		alert("아이디를 입력해주세요")
		history.back()
		document.fr.id.focus();
		return false;
	}
	
	if(document.fr.gender[0].checked == false && document.fr.gender[1].checked == false){
		alert("성별을 확인해주세요")
		history.back()
		document.fr.id.focus();
		return false;
	}
}

function winopen(){
	//새창을 열어서 페이지를 오픈 후 -> 회원아이디정보를 가지고 중복체크
	//1. 아이디가 없으면 알림창과 진행x
	if(document.fr.id.value =="" || document.fr.id.value.length < 0){
		alert("아이디를 먼저 입력해주세요")
		document.fr.id.focus();
	}else{
		//2. 회원정보아이디를 가지고 있는 지 체크하려면 DB에 접근해야한다.
		//자바스크립트로 어떻게 DB에 접근할까? => 파라미터로 id값을 가져가서 jsp페이지에서 진행하면 된다.
		window.open("joinIdCheck.jsp?userid="+document.fr.id.value,"","width=500, height=300");
	}
}
</script>
</body>
</html>