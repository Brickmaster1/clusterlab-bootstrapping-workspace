COMPOSE_FILE="compose.yaml"

curl -O https://raw.githubusercontent.com/coder/coder/refs/heads/main/${COMPOSE_FILE}

echo "→ Removing Docker-specific config"
sed -i '/\/var\/run\/docker.sock/d' ${COMPOSE_FILE}
sed -i '/#group_add:/,/docker group on host/d' ${COMPOSE_FILE}

PODMAN_SOCKET="/run/user/$(id -u)/podman/podman.sock"

if [ -S "$PODMAN_SOCKET" ]; then
    echo "→ Injecting Podman socket with correct indentation"

    awk -v sock="$PODMAN_SOCKET:/var/run/docker.sock" '
    /coder_home:\/home\/coder/ {
        match($0, /^[[:space:]]*/)
        indent = substr($0, RSTART, RLENGTH)
        print indent "- " sock
    }
    { print }
    ' ${COMPOSE_FILE} > ${COMPOSE_FILE}.tmp && mv ${COMPOSE_FILE}.tmp ${COMPOSE_FILE}
else
    echo "⚠ Podman socket not found"
    echo "Run: systemctl --user start podman.socket"
fi

echo "✓ Podman-compatible compose generated"
