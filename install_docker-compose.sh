#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y && sudo apt-get upgrade -y || { echo "Error al actualizar el sistema"; exit 1; }

# Instalar dependencias necesarias para Docker Compose
sudo apt-get install -y curl || { echo "Error al instalar dependencias para Docker Compose"; exit 1; }

# Descargar la última versión de Docker Compose
# Puedes cambiar la versión de "latest" a cualquier versión específica que necesites.
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
sudo curl -L "https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose || { echo "Error al descargar Docker Compose"; exit 1; }

# Hacer el binario de Docker Compose ejecutable
sudo chmod +x /usr/local/bin/docker-compose || { echo "Error al hacer Docker Compose ejecutable"; exit 1; }

# (Opcional) Instalar el autocompletado de comandos para Docker Compose
sudo curl -L https://raw.githubusercontent.com/docker/compose/${DOCKER_COMPOSE_VERSION}/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose || { echo "Error al instalar el autocompletado para Docker Compose"; }

echo "Docker Compose ha sido instalado correctamente"
