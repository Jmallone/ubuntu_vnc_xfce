#!/bin/bash

# Iniciar o servidor VNC
vncserver :1 -geometry 1280x800 -depth 24

# Iniciar o noVNC proxy
/opt/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen 6080 &

# Manter o container em execução
tail -f /dev/null