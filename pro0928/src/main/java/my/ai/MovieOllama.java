package my.ai;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.time.Duration;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class MovieOllama {

    // 학생 실습 환경에 맞게 수정 → ai.properties 에서 읽는다 (AiConfig)
    private static final String DB_URL = AiConfig.DB_URL;
    private static final String DB_USER = AiConfig.DB_USER;
    private static final String DB_PASSWORD = AiConfig.DB_PASSWORD;
    private static final String OLLAMA_URL = AiConfig.OLLAMA_URL;
    private static final String MODEL = AiConfig.MODEL;
    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }


    public String ask(String question) throws Exception {
        if (question == null || question.trim().isEmpty())
            throw new IllegalArgumentException("질문을 입력하세요.");
        if (question.length() > 1000)
            throw new IllegalArgumentException("질문은 1000자 이하로 입력하세요.");

        String data = getMovieData();
        String prompt = "당신은 영화 구매 통계 분석가입니다. 한국어로 간결하고 정확하게 답하세요.\n"
            + "freq는 누적 구매 횟수이고, 구매금액은 price * freq로 계산한 추정치입니다.\n"
            + "openDate는 개봉일이지 구매일이 아닙니다. 구매 시점이나 실제 시청 횟수는 알 수 없습니다.\n"
            + "freq를 통해 구매횟수가 많아지는 것이 최근 트렌드로 볼 수 있습니다.\n"
            + "movieType과 freq를 통해 영화타입의 선호도 경향을 알 수 있습니다.\n"
            + "주어진 데이터만 사용하고, 합계나 순위를 임의로 만들지 마세요.\n\n"
            + "[MySQL movie 데이터]\n" + data
            + "\n[사용자 질문]\n" + question;
        return callOllama(prompt);
    }

    private String getMovieData() throws SQLException {
        String sql = "SELECT title, maker, price, openDate, freq, movieType, "
            + "price * freq AS amount FROM movie ORDER BY freq DESC, movieId ASC LIMIT 500";
        String totalSql = "SELECT COUNT(*) AS movieCount, COALESCE(SUM(freq),0) AS purchaseCount, "
            + "COALESCE(SUM(price * freq),0) AS totalAmount FROM movie";
        StringBuilder data = new StringBuilder();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(totalSql)) {
                if (rs.next()) {
                    data.append("영화 수: ").append(rs.getInt("movieCount"))
                        .append(", 총 구매 횟수: ").append(rs.getLong("purchaseCount"))
                        .append(", 총 추정 구매금액: ").append(rs.getBigDecimal("totalAmount"))
                        .append("원\n");
                }
            }
            try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {
                while (rs.next()) {
                    data.append("영화: ").append(rs.getString("title"))
                        .append(", 제작사: ").append(rs.getString("maker"))
                        .append(", 가격: ").append(rs.getInt("price"))
                        .append("원, 개봉일: ").append(rs.getString("openDate"))
                        .append(", 영화타입: ").append(rs.getString("movieType"))
                        .append(", 구매: ").append(rs.getInt("freq"))
                        .append("회, 추정 구매금액: ").append(rs.getBigDecimal("amount"))
                        .append("원\n");
                }
            }
        }
        return data.toString();
    }

    private String callOllama(String prompt) throws Exception {
        JsonObject body = new JsonObject();
        body.addProperty("model", MODEL);
        body.addProperty("prompt", prompt);
        body.addProperty("stream", false);

        HttpRequest request = HttpRequest.newBuilder()
            .uri(URI.create(OLLAMA_URL + "/api/generate"))
            .header("Content-Type", "application/json; charset=UTF-8")
            .timeout(Duration.ofSeconds(180))
            .POST(HttpRequest.BodyPublishers.ofString(body.toString(), StandardCharsets.UTF_8))
            .build();

        HttpClient client = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(15)).build();
        HttpResponse<String> response = client.send(request,
            HttpResponse.BodyHandlers.ofString(StandardCharsets.UTF_8));

        if (response.statusCode() != 200)
            throw new RuntimeException("Ollama 오류: HTTP " + response.statusCode());

        JsonObject json = JsonParser.parseString(response.body()).getAsJsonObject();
        if (!json.has("response") || json.get("response").isJsonNull())
            throw new RuntimeException("Ollama 응답에 response 필드가 없습니다.");
        return json.get("response").getAsString();
    }
}
