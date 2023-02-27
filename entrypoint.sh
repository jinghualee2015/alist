#!/bin/bash
export ALIST_ADMIN_PASSWORD = "HZPPgN2eEvtjV5pL"
chown -R ${PUID}:${PGID} /opt/alist/

umask ${UMASK}

exec su-exec ${PUID}:${PGID} ./alist server --no-prefix