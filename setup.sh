COMPOSE_FILE="compose.yaml"
TARGET_LINE_GROUP_ADD="#group_add:"
TARGET_LINE_VOLUME="- /var/run/docker.sock:/var/run/docker.sock"

curl -O https://raw.githubusercontent.com/coder/coder/refs/heads/main/${COMPOSE_FILE}

GROUP_ADD_INDENTATION=$(grep -oP "^\s*(?=${TARGET_LINE_GROUP_ADD})" ${COMPOSE_FILE} | head -1)
DOCKER_GID=$(getent group docker | cut -d: -f3)

REPLACEMENT_BLOCK="\
${GROUP_ADD_INDENTATION}group_add:\n\
${GROUP_ADD_INDENTATION}  - \"${DOCKER_GID}\" # docker group on host"

sed -i "/${TARGET_LINE_GROUP_ADD}/,/998\" # docker group on host/c\\${REPLACEMENT_BLOCK}" ${COMPOSE_FILE}

VOLUME_INDENTATION=$(grep -oP "^\s*(?=${TARGET_LINE_VOLUME})" ${COMPOSE_FILE} | head -1)
NEW_VOLUMES="${VOLUME_INDENTATION}- /run/sysbox:/run/sysbox\\
${VOLUME_INDENTATION}- /var/lib/sysbox:/var/lib/sysbox"
sed -i "\#${TARGET_LINE_VOLUME}#a\\${NEW_VOLUMES}" ${COMPOSE_FILE}
