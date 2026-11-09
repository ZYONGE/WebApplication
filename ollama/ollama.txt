<%@ page contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ page import="my.ai.OllamaClient" %>

<%!
    // 입력과 답변을 HTML에 안전하게 출력
    private String escapeHtml(String text) {
        if (text == null) return "";

        return text.replace("&", "&amp;")
                   .replace("<", "&lt;")
                   .replace(">", "&gt;")
                   .replace("\"", "&quot;")
                   .replace("'", "&#39;");
    }
%>

<%
    request.setCharacterEncoding("UTF-8");

    String question = request.getParameter("question");
    String answer = "";
    String error = "";

    if ("POST".equals(request.getMethod())
            && question != null
            && !question.trim().isEmpty()) {

        try {
            OllamaClient ollama = new OllamaClient();
            answer = ollama.ask(question.trim());

        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            error = "요청 처리가 중단되었습니다.";

        } catch (Exception e) {
            error = "답변 생성 실패: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>JSP + Ollama 실습</title>

    <style>
        body {
            max-width: 760px;
            margin: 40px auto;
            padding: 0 20px;
            font-family: sans-serif;
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

    <h2>JSP + Ollama 질문하기</h2>

    <form method="post" action="ollama.jsp"
          onsubmit="document.getElementById('send').disabled=true;
                    document.getElementById('send').textContent='답변 생성 중…';">

        <textarea name="question"
                  rows="5"
                  placeholder="질문을 입력하세요."
                  required><%= escapeHtml(question) %></textarea>

        <button id="send" type="submit">질문하기</button>
    </form>

    <% if (!answer.isEmpty()) { %>
        <h3>Gemma 답변</h3>
        <div class="answer"><%= escapeHtml(answer) %></div>
    <% } %>

    <% if (!error.isEmpty()) { %>
        <div class="error"><%= escapeHtml(error) %></div>
    <% } %>

</body>
</html>