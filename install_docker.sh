#!/bin/bash

# Actualizar el sistema
sudo apt-get update -y && sudo apt-get upgrade -y || { echo "Error al actualizar el sistema"; exit 1; }

# Instalar dependencias necesarias
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release -y || { echo "Error al instalar dependencias"; exit 1; }

# Agregar la llave GPG de Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || { echo "Error al agregar la llave GPG de Docker"; exit 1; }

# Agregar el repositorio de Docker al sistema
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || { echo "Error al agregar el repositorio de Docker"; exit 1; }

# Actualizar el sistema para incluir el repositorio de Docker
sudo apt-get update -y || { echo "Error al actualizar el sistema con el repositorio de Docker"; exit 1; }

# Instalar Docker
sudo apt-get install docker-ce docker-ce-cli containerd.io -y || { echo "Error al instalar Docker"; exit 1; }

# Habilitar y arrancar el servicio de Docker
sudo systemctl enable docker && sudo systemctl start docker || { echo "Error al habilitar o arrancar el servicio de Docker"; exit 1; }

echo "Docker ha sido instalado y configurado correctamente"

