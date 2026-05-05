#!/bin/bash
systemctl daemon-reload
systemctl enable muthur-command-agent.service
systemctl start muthur-command-agent.service
