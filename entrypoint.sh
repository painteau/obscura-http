#!/bin/sh

# Auto-restart loop for obscura
start_obscura() {
  while true; do
    ./obscura serve --port 9222 --stealth
    echo "[obscura] crashed, restarting in 1s..."
    sleep 1
  done
}

start_obscura &
sleep 2

# node crash = container exits = Docker restarts container (restart: unless-stopped)
exec node server.js
