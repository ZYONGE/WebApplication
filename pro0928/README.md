# pro0928 — 영화 구매 데이터 AI 분석 (Ollama · Gemma 3)

웹프로그래밍응용 실습 프로젝트(`2023314022.zip`)를 이 저장소에서 그대로 재현한다.
`web.movie` 의 누적 구매 데이터를 Java 가 집계해 프롬프트로 만들고, 수업 GPU 클러스터의 Ollama(`gemma3:12b`)가 분석한다.

```
브라우저 → Tomcat(pro0928) → MovieOllama ─┬─ MySQL localhost:3306/web (movie)
                                          └─ localhost:11435 → kubectl port-forward → 클러스터 Ollama
                                                    ↑ 클러스터 API 는 SSH 터널 localhost:36443 → stud08@220.149.119.234:6443
```

| 페이지 | 클래스 | 데이터 |
|---|---|---|
| `ollama/movieollama.jsp` | `my.ai.MovieOllama` | `movie` (freq · movieType) |
| `ollama/ollamapurchase.jsp` | `my.ai.OllamaPurchase` | `purchase` |
| `CHAPTER10/*.jsp` | `my.dao.*` | 9~11월 실습 (DBCP `pool.jocl`) |

## 원본과 달라진 점

- **접속 정보 분리** — DB · Ollama 주소를 소스 상수 대신 `src/main/java/ai.properties` 에서 읽는다(`my.ai.AiConfig`). 파일이 없으면 원본 값(`root` / `12345` / `localhost:11435` / `gemma3:12b`)을 그대로 쓴다. `ai.properties` 는 git 제외, 템플릿은 `ai.properties.example`.
- **JDK 17** — Eclipse 설정(.classpath · facet · compiler)을 11 → 17 로 맞췄다.
- 커넥터 jar 이름 정리: `mysql-connector-java-8.0.28 (1) (1).jar` → `mysql-connector-java-8.0.28.jar`.
- `CHAPTER10` 의 DBCP(`pool.jocl`)는 원본 그대로 `root` / `12345` 다. CHAPTER10 페이지를 쓸 때만 필요하면 고친다.

## 실행 순서

### 0. DB 준비 (1회)

`MovieOllama` 는 `movie.movieType` 컬럼을 쓴다. 로컬 `web.movie` 에는 이 컬럼이 없고 freq 가 모두 0 이라, 시드를 한 번 적용한다.

```bash
mysql -D web < sql/movie_ai_seed.sql
```

- 컬럼이 없을 때만 추가하고, 10편의 movieType · freq 를 채운다. 다시 실행해도 결과는 같다.
- 실습 결과 화면에 나온 값(SF: 아일랜드 87 · 헬보이 55 · 백 투 더 퓨처 1 / 코미디: 웰컴 투 동막골 66 · 완득이 33 · 써니 4)은 그대로 넣었다. 나머지 4편(괴물 · 라디오스타 · 비열한 거리 · 왕의 남자)은 화면에 없어 작은 값으로 임의로 채웠다.

### 1. stud08 클러스터 터널 (터미널 ①, 켜 둔다)

```bash
tools/stud08-tunnel.sh
```

`ssh -L 36443:localhost:6443 stud08@220.149.119.234` 와 같다. 비밀번호는 직접 입력한다.
`~/.kube/config` 는 이미 context `stud08`, `server: https://localhost:36443` 로 잡혀 있다.

### 2. Ollama port-forward (터미널 ②, 켜 둔다)

```bash
tools/ollama-forward.sh
```

- 실습 화면의 `kubectl -n default port-forward svc/ollama 11435:11434` 를 먼저 시도한다.
- stud08 계정에 `default` namespace 권한이 없으면, 기말프로젝트 LLM 브랜치에서 검증한 방식으로 자동 전환한다: 내 namespace 에 `k8s/llm-relay.yaml`(socat 중계 파드)을 올리고 `127.0.0.1:11435` 로 잇는다. 끝낸 뒤 `tools/ollama-forward.sh down` 으로 파드를 지운다.

### 3. 연결 확인

```bash
tools/check-ollama.sh
```

모델 목록 · 생성 · JSON 응답 3단계가 PASS 면 된다.

### 4. 앱 실행

**Eclipse** — `File > Import > Existing Projects into Workspace` 로 이 `pro0928` 폴더를 열고, Tomcat v9.0 서버에 추가해 시작한다.

**CLI** — Eclipse 없이 돌릴 때 (기존 Tomcat 설정은 건드리지 않고 `build/tomcat` 을 CATALINA_BASE 로 쓴다):

```bash
tools/run-local.sh
```

접속: <http://localhost:8080/pro0928/ollama/movieollama.jsp>

질문 예: `고객들이 선호하는 영화타입은?` → SF(아일랜드 87회 · 헬보이 55회 · 백 투 더 퓨처 1회)가 가장 높고 코미디(웰컴 투 동막골 66회 · 완득이 33회 · 써니 4회)가 뒤를 잇는다는 답이 나온다. LLM 응답이라 문장은 매번 조금씩 다르다.

## 문제 해결

| 증상 | 원인 · 조치 |
|---|---|
| `(SQLSyntaxErrorException)` | `movieType` 컬럼 없음 → 0단계 시드 실행 |
| `(SQLException)` Access denied | `ai.properties` 의 `db.user` · `db.password` 확인 |
| `(ConnectException)` | 11435 port-forward 가 꺼짐 → 1 · 2단계 확인 |
| `ollama-forward.sh` 가 클러스터에 닿지 않음 | 터널(36443) 꺼짐 또는 kube context 가 stud08 이 아님 |
| `(HttpTimeoutException)` | 공용 서버 부하. 180초 타임아웃 후 다시 시도 |
