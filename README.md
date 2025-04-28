# Ubuntu VNC Container

Este repositório contém arquivos para criar um container Docker com Ubuntu 22.04, ambiente gráfico XFCE4, VNC Server e noVNC para acesso via navegador web.

## Características

- Sistema base: Ubuntu 22.04
- Interface gráfica: XFCE4
- Acesso remoto: VNC (porta 5901) e noVNC web interface (porta 6080)
- Firefox pré-instalado
- Python 3 com selenium, beautifulsoup4, pyautogui e lxml
- Geckodriver para automação no Firefox

## Requisitos

- Docker
- Docker Compose (para execução local)
- Portainer (para implantação via interface web)

## Implantação Local

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/ubuntu-vnc-container.git
   cd ubuntu-vnc-container
   ```

2. Inicie o container:
   ```bash
   docker-compose up -d
   ```

3. Acesse via:
   - VNC client: `localhost:5901` (senha padrão: 123456)
   - Navegador web: `http://localhost:6080`

## Implantação via Portainer

1. No Portainer, vá para "Stacks" e clique em "Add stack"
2. Selecione "Git Repository" como método
3. Preencha:
   - Repository URL: https://github.com/seu-usuario/ubuntu-vnc-container.git
   - Reference: main (ou master, dependendo da sua branch principal)
   - Compose path: docker-compose.yml
4. Clique em "Deploy the stack"

## Configuração

Para alterar a senha VNC padrão, você pode:

- Editar o valor no Dockerfile
- Ou definir a variável de ambiente `VNC_PASSWORD` quando executar o container

## Volumes

- `ubuntu-data`: Volume persistente para armazenar os dados do usuário root
- Um diretório compartilhado opcional está comentado no docker-compose.yml para compartilhamento com o host

## Acessando o Container

Uma vez em execução, você pode acessar:

- Usando um cliente VNC (como VNC Viewer): conecte em `localhost:5901` (ou IP do servidor)
- Via navegador web: acesse `http://localhost:6080` (ou http://[IP-do-servidor]:6080)

## Customização

Para instalar pacotes adicionais, você pode:

1. Modificar o Dockerfile e reconstruir a imagem
2. Ou acessar o terminal dentro do container em execução e instalar manualmente