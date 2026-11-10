#!/bin/bash
# Eclipse 없이 CLI 로 빌드 · 실행한다 (Eclipse 에서 Tomcat 으로 돌릴 때는 필요 없다).
# build/webapp 에 exploded WAR 를 만들고, 기존 Tomcat 설정은 건드리지 않도록
# build/tomcat 을 CATALINA_BASE 로 써서 http://localhost:8080/pro0928/ 로 띄운다.
#
# 사용법: tools/run-local.sh          빌드 후 Tomcat 실행 (Ctrl+C 로 종료)
#         tools/run-local.sh build    빌드만
#         CATALINA_HOME=/path/to/tomcat tools/run-local.sh
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CATALINA_HOME="${CATALINA_HOME:-$HOME/Developer/Server/apache-tomcat-9.0.117}"
APP="$ROOT/build/webapp"
BASE="$ROOT/build/tomcat"

[ -f "$CATALINA_HOME/lib/servlet-api.jar" ] || { echo "Tomcat 을 찾을 수 없습니다: $CATALINA_HOME"; exit 1; }

rm -rf "$APP"; mkdir -p "$APP/WEB-INF/classes"
rsync -a "$ROOT/WebContents/" "$APP/"
javac -encoding UTF-8 --release 17 -nowarn \
	-cp "$ROOT/WebContents/WEB-INF/lib/*:$CATALINA_HOME/lib/servlet-api.jar" \
	-d "$APP/WEB-INF/classes" $(find "$ROOT/src/main/java" -name '*.java')
# 클래스패스 리소스 (Eclipse 가 build/classes 로 복사하는 것과 같다)
(cd "$ROOT/src/main/java" && find . -type f ! -name '*.java' ! -name '*.example' -exec cp {} "$APP/WEB-INF/classes/" \;)
echo "[build] $APP"
[ "${1:-}" = "build" ] && exit 0

mkdir -p "$BASE/conf/Catalina/localhost" "$BASE/logs" "$BASE/temp" "$BASE/webapps" "$BASE/work"
cp "$CATALINA_HOME/conf/"{server.xml,web.xml,context.xml,logging.properties,catalina.properties,tomcat-users.xml} "$BASE/conf/" 2>/dev/null || true
cat > "$BASE/conf/Catalina/localhost/pro0928.xml" <<XML
<Context docBase="$APP" reloadable="false" />
XML
echo "[run] http://localhost:8080/pro0928/ollama/movieollama.jsp"
CATALINA_BASE="$BASE" exec "$CATALINA_HOME/bin/catalina.sh" run
