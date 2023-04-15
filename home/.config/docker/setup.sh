__dirname="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$__dirname/../pre_setup.sh"

ensure_installed docker
ensure_installed docker-compose

newgroup docker
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker ${USER}

sudo systemctl restart docker.service
echo "Please relogin."
