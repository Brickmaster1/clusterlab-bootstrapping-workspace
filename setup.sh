COMPOSE_FILE="compose.yaml"
curl -O https://raw.githubusercontent.com/coder/coder/refs/heads/main/${COMPOSE_FILE}

sed -i "/#group_add:/,/998\" # docker group on host/c\
\    group_add:\n\      - \"$(getent group docker | cut -d: -f3)\" # docker group on host" ${COMPOSE_FILE}
