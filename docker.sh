#!/bin/bash
echo "Instalando o Docker"
sudo apt install docker.io
echo "Docker instalado com sucesso"

echo "Iniciando o serviço do Docker"
sudo systemctl start docker
sudo systemctl enable docker

echo "Baixando a imagem MySQL"
sudo docker pull mysql:8.0

echo "Imagem MySQL baixada com sucesso"

echo "Criando e executando o container MySQL"
sudo docker run -d -p 3306:3306 --name ByteGuard -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8.0
echo "Container MySQL criado e em execução"

echo "Executando o script SQL dentro do container MySQL"
sudo docker exec -i ByteGuard mysql -u root -paluno < /home/ubuntu/docker-scripts-repo/script.sql
echo "Script SQL executado com sucesso!"

echo "Dando permissão de execução ao arquivo install_java.sh"
chmod +x java.sh
echo "Permissão concedida com sucesso"

echo "Executando o arquivo java.sh"
./java.sh
echo "Arquivo java.sh executado com sucesso!"
