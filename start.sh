#!/usr/bin/env bash

set -e

# Always run Docker Compose from the directory containing this script.
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

if docker compose version >/dev/null 2>&1; then
  COMPOSE=(docker compose)
elif command -v docker-compose >/dev/null 2>&1; then
  COMPOSE=(docker-compose)
else
  echo "错误：未找到 Docker Compose。请先安装并启动 Docker Desktop。" >&2
  exit 1
fi

echo "=== 构建 Docker 镜像（仅在依赖变动时 rebuild） ==="
"${COMPOSE[@]}" build

echo "=== 启动开发容器 ==="
"${COMPOSE[@]}" up
