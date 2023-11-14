#!/bin/sh

# Instalação do Docker
sudo apt install docker.io

# Iniciar o serviço do Docker
sudo systemctl start docker
sudo systemctl enable docker

# Download da imagem do MySQL
sudo docker pull mysql:5.7

# Criar e executar o container MySQL
sudo docker run -d -p 3306:3306 --name magister -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7

# Executar o script SQL dentro do container MySQL
# sudo docker exec -i magister mysql -u root -paluno < /home/ubuntu/banco-de-dados/script.sql

# Dar permissão de execução ao arquivo install_java.sh
# chmod +x install_java.sh

# Executar o arquivo java.sh
# ./install_java.sh


