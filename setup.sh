COMPOSE_FILE="compose.yaml"

curl -O https://raw.githubusercontent.com/coder/coder/refs/heads/main/${COMPOSE_FILE}

sed -i '/\/var\/run\/docker.sock/d' ${COMPOSE_FILE}
sed -i '/#group_add:/,/docker group on host/d' ${COMPOSE_FILE}

PODMAN_SOCKET="/run/user/$(id -u)/podman/podman.sock"

if [ -S "$PODMAN_SOCKET" ]; then
    awk -v sock="$PODMAN_SOCKET:/var/run/docker.sock" '
    /coder_home:\/home\/coder/ {
        match($0, /^[[:space:]]*/)
        indent = substr($0, RSTART, RLENGTH)
        print indent "- " sock
    }
    { print }
    ' ${COMPOSE_FILE} > ${COMPOSE_FILE}.tmp && mv ${COMPOSE_FILE}.tmp ${COMPOSE_FILE}
fi
