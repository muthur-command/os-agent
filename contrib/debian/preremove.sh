#!/bin/bash
systemctl stop muthur-command-agent.service >/dev/null 2>&1 || true
systemctl disable muthur-command-agent.service >/dev/null 2>&1 || true
