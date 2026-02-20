#!/usr/bin/env bash
set -euo pipefail

SECRETS_FILE=$(mktemp)
trap "rm -f $SECRETS_FILE" EXIT

# Populate secrets from 1Password
cat > "$SECRETS_FILE" <<EOF
IQ_USERNAME=$(op read "op://Private/Localhost - Sonatype Lifecycle User Token/username")
IQ_SERVER_URL="http://localhost:8070/"
IQ_PASSWORD=$(op read "op://Private/Localhost - Sonatype Lifecycle User Token/credential")
NEXUS_NPM_AUTH_TOKEN=$(op read "op://Private/Nexus Repo - localhost-8081/password")
NEXUS_NPM_REGISTRY_URL="http://localhost:8081/repository/npm-group/"
EOF

act "$@" --secret-file "$SECRETS_FILE"
