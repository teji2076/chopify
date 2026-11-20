#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
mkdir -p projects
if [ ! -x .venv/bin/python ]; then
 python3 -m venv .venv
 .venv/bin/pip install -r requirements.txt
fi
export CHOPIFY_ORIGIN="https://${CODESPACE_NAME}-8765.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN:-app.github.dev}"
if curl -fsS http://127.0.0.1:8765/api/config >/dev/null 2>&1; then exit 0; fi
nohup .venv/bin/python dashboard.py --no-browser >projects/server.log 2>&1 </dev/null &
