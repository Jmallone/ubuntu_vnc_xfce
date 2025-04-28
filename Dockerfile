# Base: Ubuntu minimal
FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV VNC_PASSWORD=123456
# Atualiza o sistema e instala pacotes necessários
RUN apt update && apt install -y \
    sudo \
    xfce4 xfce4-goodies \
    xorg dbus-x11 \
    tigervnc-standalone-server tigervnc-common \
    firefox \
    wget curl net-tools \
    python3 python3-pip \
    git \
    && apt clean && rm -rf /var/lib/apt/lists/*
# Garante que python é acessível como "python"
RUN ln -sf /usr/bin/python3 /usr/bin/python
# Instala o noVNC e websockify
WORKDIR /opt
RUN git clone https://github.com/novnc/noVNC.git && \
    git clone https://github.com/novnc/websockify noVNC/utils/websockify
# Configuração do VNC e XFCE
RUN mkdir -p /root/.vnc && \
    echo '#!/bin/sh\n'\
'unset SESSION_MANAGER\n'\
'unset DBUS_SESSION_BUS_ADDRESS\n'\
'export XDG_SESSION_TYPE=x11\n'\
'export DISPLAY=:1\n'\
'exec startxfce4\n' > /root/.vnc/xstartup && chmod +x /root/.vnc/xstartup
# Define senha padrão para VNC
RUN echo "$VNC_PASSWORD" | vncpasswd -f > /root/.vnc/passwd && \
    chmod 600 /root/.vnc/passwd
# Instala pacotes Python necessários
RUN pip install --no-cache-dir selenium beautifulsoup4 pyautogui lxml
# Instala o Geckodriver (compatível com Firefox)
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.34.0/geckodriver-v0.34.0-linux64.tar.gz && \
    tar -xvzf geckodriver-v0.34.0-linux64.tar.gz && \
    mv geckodriver /usr/local/bin/ && \
    chmod +x /usr/local/bin/geckodriver && \
    rm geckodriver-v0.34.0-linux64.tar.gz
# Cria um script de inicialização
COPY start.sh /start.sh
RUN chmod +x /start.sh
# Expor as portas do container
EXPOSE 5901 6080
# Healthcheck básico para o noVNC
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s CMD curl -f http://localhost:6080 || exit 1
# Comando para iniciar VNC Server e noVNC Proxy juntos
CMD ["/start.sh"]