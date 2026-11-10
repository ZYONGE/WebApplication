-- 영화 구매 데이터 AI 분석(ollama/movieollama.jsp) 실습용 데이터
-- web.movie 에 movieType 컬럼을 추가하고 누적 구매횟수(freq)를 채운다.
-- 여러 번 실행해도 같은 상태가 된다.
--
--   mysql -D web < sql/movie_ai_seed.sql
--
-- 실습 결과 화면에 나온 값: SF(아일랜드 87 · 헬보이 55 · 백 투 더 퓨처 1),
-- 코미디(웰컴 투 동막골 66 · 완득이 33 · 써니 4). 나머지 4편은 화면에 없어 임의로 채웠다.

SET NAMES utf8mb4;

-- movieType 컬럼이 없을 때만 추가 (MySQL 에는 ADD COLUMN IF NOT EXISTS 가 없다)
SET @has_col := (SELECT COUNT(*) FROM information_schema.COLUMNS
                 WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'movie' AND COLUMN_NAME = 'movieType');
SET @ddl := IF(@has_col = 0,
               'ALTER TABLE movie ADD COLUMN movieType VARCHAR(20) DEFAULT NULL AFTER freq',
               'DO 0');
PREPARE stmt FROM @ddl;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

UPDATE movie SET movieType = 'SF',   freq = 87 WHERE title = '아일랜드';
UPDATE movie SET movieType = 'SF',   freq = 55 WHERE title LIKE '헬보이%';
UPDATE movie SET movieType = 'SF',   freq = 1  WHERE title = '백 투 더 퓨처';
UPDATE movie SET movieType = '코미디', freq = 66 WHERE title = '웰컴 투 동막골';
UPDATE movie SET movieType = '코미디', freq = 33 WHERE title = '완득이';
UPDATE movie SET movieType = '코미디', freq = 4  WHERE title = '써니';
UPDATE movie SET movieType = '스릴러', freq = 3  WHERE title = '괴물';
UPDATE movie SET movieType = '드라마', freq = 2  WHERE title = '라디오스타';
UPDATE movie SET movieType = '액션',   freq = 2  WHERE title = '비열한 거리';
UPDATE movie SET movieType = '드라마', freq = 3  WHERE title = '왕의 남자';

SELECT movieId, title, movieType, price, freq, price * freq AS amount
FROM movie ORDER BY freq DESC, movieId;
