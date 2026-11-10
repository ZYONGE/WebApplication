<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="my.ai.MovieOllama" %>
<%!
    private String esc(String text) {
        if (text == null) return "";
        return text.replace("&", "&amp;").replace("<", "&lt;")
                   .replace(">", "&gt;").replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
%>
<%
    request.setCharacterEncoding("UTF-8");
    String question = request.getParameter("question");
    String answer = "";
    String error = "";
    if ("POST".equalsIgnoreCase(request.getMethod()) && question != null && !question.trim().isEmpty()) {
        try {
            answer = new MovieOllama().ask(question);
        } catch (Exception e) {
            application.log("영화 데이터 AI 분석 실패", e);
            error = "분석에 실패했습니다. MySQL/Ollama 주소, 비밀번호, 서버 로그를 확인하세요. (" + e.getClass().getSimpleName() + ")";
        }
    }
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>영화 구매 데이터 AI 분석</title>
<style>
body{font:16px/1.65 system-ui,sans-serif;max-width:850px;margin:35px auto;padding:0 18px;color:#222}
h1{font-size:27px}.hint{background:#f5f5f5;padding:16px;border-radius:8px}
textarea{width:100%;box-sizing:border-box;padding:12px;font:inherit;border:1px solid #aaa;border-radius:6px}
button{margin-top:12px;padding:10px 20px;background:#222;color:white;border:0;border-radius:6px;cursor:pointer}
.answer,.error{margin-top:18px;padding:18px;border:1px solid #ddd;border-radius:8px;white-space:pre-wrap;overflow-wrap:anywhere}
.error{color:#a40000}.note{color:#666;font-size:14px}
</style>
</head>
<body>
<h1>영화 구매 데이터 AI 분석</h1>
<p>MySQL <code>web.movie</code>의 누적 구매 데이터를 Java가 집계하고 Gemma 3가 설명합니다.</p>
<div class="hint"><strong>질문 예시</strong>
<ul>
<li>구매횟수가 가장 많은 영화 TOP 5를 알려줘.</li>
<li>전체 구매 횟수와 추정 구매금액 합계는?</li>
<li>구매금액이 가장 높은 영화와 제작사를 비교해줘.</li>
<li>최근 개봉한 영화들의 누적 구매 실적을 비교해줘.</li>
<li>최근 개봉한 영화들의 영화타입 선호도를 분석해줘.</li>
</ul>
</div>
<p class="note">freq는 누적 구매횟수입니다. 구매일시 데이터가 없어 최근 7일 구매량이나 실시간 트렌드는 계산할 수 없습니다.</p>
<form method="post" action="movieollama.jsp" onsubmit="document.getElementById('send').disabled=true;document.getElementById('send').textContent='분석 중...';">
<textarea name="question" rows="4" maxlength="1000" required placeholder="영화 구매 데이터에 대해 질문하세요."><%= esc(question) %></textarea>
<button id="send" type="submit">Gemma 분석하기</button>
</form>
<% if (!answer.isEmpty()) { %><h2>Gemma 3 분석 결과</h2><div class="answer"><%= esc(answer) %></div><% } %>
<% if (!error.isEmpty()) { %><div class="error"><%= esc(error) %></div><% } %>
</body>
</html>
