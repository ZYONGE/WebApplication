#!/bin/bash
# 1단계 — 수업 GPU 클러스터 API(6443)를 Mac 의 localhost:36443 으로 여는 SSH 터널.
# 실습 화면의  ssh -L 36443:localhost:6443 stud08@220.149.119.234  와 같다.
# 비밀번호를 물으면 직접 입력하고, 이 창은 켜 둔다 (Ctrl+C 로 종료).
#
# 사용법: tools/stud08-tunnel.sh            (기본 계정 stud08)
#         STUD=stud09 tools/stud08-tunnel.sh
STUD="${STUD:-stud08}"
HOST="${HOST:-220.149.119.234}"
echo "[tunnel] localhost:36443 → $HOST:6443 ($STUD) — 이 창을 닫지 마세요."
exec ssh -N -o ExitOnForwardFailure=yes -o ServerAliveInterval=30 \
	-L 36443:localhost:6443 "$STUD@$HOST"
