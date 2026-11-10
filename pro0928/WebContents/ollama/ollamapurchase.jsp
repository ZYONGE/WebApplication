<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="my.ai.OllamaPurchase" %>

<%!private String escapeHtml(String text) {
        if (text == null) return "";

        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }%>

<%
request.setCharacterEncoding("UTF-8");

    String question = request.getParameter("question");
    String answer = "";
    String error = "";

    if ("POST".equals(request.getMethod())
            && question != null
            && !question.trim().isEmpty()) {

        try {
            OllamaPurchase ollama = new OllamaPurchase();
            answer = ollama.ask(question);

        } catch (java.sql.SQLException e) {
            application.log("구매 데이터 조회 실패", e);
            error = "DB 조회에 실패했습니다. 서버 로그와 DB 설정을 확인하세요.";

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            error = "요청 처리가 중단되었습니다.";

        } catch (Exception e) {
            application.log("Ollama 호출 실패", e);
            error = "AI 답변 생성에 실패했습니다. 서버 로그와 Ollama 연결을 확인하세요.";
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>구매 데이터 AI 분석</title>

    <style>
        body {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
            font-family: sans-serif;
            line-height: 1.6;
        }

        textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            font: inherit;
        }

        button {
            margin-top: 10px;
            padding: 10px 20px;
            cursor: pointer;
        }

        .hint {
            padding: 15px;
            background: #f5f5f5;
            margin-bottom: 20px;
        }

        .answer, .error {
            margin-top: 20px;
            padding: 20px;
            border: 1px solid #ccc;
            white-space: pre-wrap;
            overflow-wrap: anywhere;
        }

        .error {
            color: #b00020;
        }
    </style>
</head>
<body>

    <h2>구매 데이터 AI 분석</h2>

    <p>MySQL의 오늘 구매 데이터를 조회하여 Gemma가 설명합니다.</p>

    <div class="hint">
        <strong>질문 예시</strong>
        <ul>
            <li>오늘 구매액이 가장 많은 고객은 누구야?</li>
            <li>고객별 구매액과 구매횟수를 비교해 줘.</li>
            <li>오늘 구매액이 가장 높은 시간대는 언제야?</li>
            <li>오늘의 구매 현황을 요약해 줘.</li>
        </ul>
    </div>

    <form method="post" action="ollamapurchase.jsp"
          onsubmit="document.getElementById('send').disabled=true;
                    document.getElementById('send').textContent='분석 중…';">

        <textarea name="question"
                  rows="4"
                  placeholder="오늘 구매 데이터에 대해 질문하세요."
                  required><%= escapeHtml(question) %></textarea>

        <button id="send" type="submit">분석하기</button>
    </form>

    <% if (!answer.isEmpty()) { %>
        <h3>Gemma 분석 결과</h3>
        <div class="answer"><%= escapeHtml(answer) %></div>
    <% } %>

    <% if (!error.isEmpty()) { %>
        <div class="error"><%= escapeHtml(error) %></div>
    <% } %>

</body>
</html>