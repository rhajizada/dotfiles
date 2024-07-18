sudo snap install microk8s --classic
sudo usermod -a -G microk8s hajizar
newgrp microk8s
sudo chown -R hajizar ~/.kube
microk8s status --wait-ready
microk8s config >~/.kube/config
microk8s enable dashboard
microk8s enable dns
microk8s enable registry
microk8s enable istio
