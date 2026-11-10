package my.ai;

import java.io.InputStream;
import java.util.Properties;

/**
 * DB · Ollama 접속 정보.
 * 클래스패스의 ai.properties(src/main/java/ai.properties, git 제외)가 있으면 그 값을,
 * 없으면 실습 원본 값(root/12345, localhost:11435, gemma3:12b)을 쓴다.
 * 템플릿: src/main/java/ai.properties.example
 */
final class AiConfig {

    private static final Properties PROPS = load();

    static final String DB_URL = get("db.url", "jdbc:mysql://localhost:3306/web");
    static final String DB_USER = get("db.user", "root");
    static final String DB_PASSWORD = get("db.password", "12345");
    static final String OLLAMA_URL = get("ollama.url", "http://localhost:11435");
    static final String MODEL = get("ollama.model", "gemma3:12b");

    private AiConfig() {}

    private static Properties load() {
        Properties p = new Properties();
        try (InputStream in = AiConfig.class.getResourceAsStream("/ai.properties")) {
            if (in != null) p.load(in);
        } catch (Exception e) {
            // 파일이 없거나 읽기 실패 시 기본값 사용
        }
        return p;
    }

    private static String get(String key, String def) {
        String v = PROPS.getProperty(key);
        return (v == null || v.trim().isEmpty()) ? def : v.trim();
    }
}
