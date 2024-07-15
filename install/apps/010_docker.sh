sudo pacman -S docker
sudo usermod -aG docker ${USER}
sudo systemctl enable docker.service
# Use local logging driver - it's more efficient and uses compression by default.
echo '{"log-driver":"local","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json >/dev/null
