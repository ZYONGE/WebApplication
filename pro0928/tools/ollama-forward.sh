#!/bin/bash
# 2단계 — 클러스터의 Ollama 를 Mac 의 localhost:11435 로 port-forward 한다.
# 실습 화면의  kubectl -n default port-forward svc/ollama 11435:11434  와 같다.
# 앱(ai.properties ollama.url)은 http://localhost:11435 를 부른다.
#
# 먼저 할 것: tools/stud08-tunnel.sh 가 다른 창에서 켜져 있고,
#             ~/.kube/config 의 server 가 https://localhost:36443, context 가 stud08 일 것.
#
# 사용법: tools/ollama-forward.sh          svc/ollama 로 연결 (권한이 없으면 중계 파드로 자동 전환)
#         tools/ollama-forward.sh relay    처음부터 중계 파드(k8s/llm-relay.yaml)로 연결
#         tools/ollama-forward.sh down     내 namespace 의 중계 파드를 지운다
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
PORT="${PORT:-11435}"
MODE="${1:-svc}"

kubectl --request-timeout=10s get --raw=/readyz > /dev/null 2>&1 || {
	echo "클러스터 API 에 닿지 않습니다 — tools/stud08-tunnel.sh(localhost:36443)와"
	echo "context($(kubectl config current-context 2>/dev/null))를 확인하세요."
	exit 1
}

if [ "$MODE" = "down" ]; then
	exec kubectl delete -f "$ROOT/k8s/llm-relay.yaml" --ignore-not-found
fi

if [ "$MODE" = "svc" ]; then
	if [ "$(kubectl auth can-i create pods/portforward -n default 2>/dev/null)" = "yes" ] \
		&& kubectl -n default get svc ollama > /dev/null 2>&1; then
		echo "[forward] 127.0.0.1:$PORT → default/svc/ollama:11434 — 확인: tools/check-ollama.sh"
		exec kubectl -n default port-forward svc/ollama "$PORT:11434"
	fi
	echo "[forward] default/svc/ollama 에 port-forward 권한이 없습니다 → 내 namespace 중계 파드로 전환합니다."
fi

kubectl apply -f "$ROOT/k8s/llm-relay.yaml" || exit 1
kubectl rollout status deployment/llm-relay --timeout=120s || exit 1
echo "[forward] 127.0.0.1:$PORT → llm-relay 파드 → 220.149.119.234:31434 — 확인: tools/check-ollama.sh"
exec kubectl port-forward --address 127.0.0.1 deployment/llm-relay "$PORT:31434"
