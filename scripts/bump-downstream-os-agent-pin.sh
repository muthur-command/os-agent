#!/usr/bin/env bash
# Bump pinned os-agent release in downstream MCOS repositories.
#
# Usage: bump-downstream-os-agent-pin.sh <repo-name> <checkout-root> <version>
#   repo-name: operating-system | devcontainer
#   version: GitHub release tag (mc_ prefix is stripped for pin values)

set -euo pipefail

REPO="${1:?repo name required}"
ROOT="${2:?checkout root required}"
VER="${3:?version required}"
VER="${VER#mc_}"

log() { echo "[bump-downstream-os-agent-pin] $*"; }

case "${REPO}" in
  operating-system)
    f="${ROOT}/buildroot-external/package/os-agent/os-agent.mk"
    [[ -f "${f}" ]] || {
      log "missing ${f}"
      exit 1
    }
    sed -i -E "s/^OS_AGENT_VERSION = .*/OS_AGENT_VERSION = ${VER}/" "${f}"
    sed -i -E "s/-X main\\.version=[^ ]+/-X main.version=${VER}/" "${f}"
    log "updated os-agent.mk (OS_AGENT_VERSION and main.version)"
    ;;
  devcontainer)
    f="${ROOT}/common/install/versions.json"
    [[ -f "${f}" ]] || {
      log "missing ${f}"
      exit 1
    }
    sed -i -E "s/\"os-agent\": \"[^\"]+\"/\"os-agent\": \"${VER}\"/" "${f}"
    log "updated common/install/versions.json"
    ;;
  *)
    log "unknown repo: ${REPO}"
    exit 1
    ;;
esac
