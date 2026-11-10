package my.ai;

import java.io.IOException;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.time.Duration;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class OllamaClient {

    private static final String API_URL =
            AiConfig.OLLAMA_URL + "/api/generate";

    private static final String MODEL = AiConfig.MODEL;

    private final HttpClient client = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    public String ask(String question)
            throws IOException, InterruptedException {

        JsonObject body = new JsonObject();
        body.addProperty("model", MODEL);
        body.addProperty("prompt", question);
        body.addProperty("stream", false);

        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(API_URL))
                .timeout(Duration.ofSeconds(180))
                .header("Content-Type", "application/json")
                .POST(HttpRequest.BodyPublishers.ofString(
                        body.toString(),
                        StandardCharsets.UTF_8))
                .build();

        HttpResponse<String> response = client.send(
                request,
                HttpResponse.BodyHandlers.ofString(
                        StandardCharsets.UTF_8));

        if (response.statusCode() != 200) {
            throw new IOException(
                    "Ollama 오류: HTTP " + response.statusCode()
                    + "\n" + response.body());
        }

        JsonObject result = JsonParser
                .parseString(response.body())
                .getAsJsonObject();

        if (!result.has("response")
                || result.get("response").isJsonNull()) {
            throw new IOException("Ollama 응답에 답변이 없습니다.");
        }

        return result.get("response").getAsString();
    }
}