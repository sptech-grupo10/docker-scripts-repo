#!/bin/sh
# Mensagem informativa sobre a instalação do Docker
echo "Instalando o Docker..."
sudo apt install docker.io
echo "Docker instalado com sucesso!"
# Iniciar o serviço do Docker
echo "Iniciando o serviço do Docker..."
sudo systemctl start docker
sudo systemctl enable docker
# Baixar a imagem do MySQL 5.7
echo "Baixando a imagem do MySQL 8.0..."
sudo docker pull mysql:8.0
echo "Imagem do MySQL 5.7 baixada com sucesso!"
# Criar e executar o container MySQL
echo "Criando e executando o container MySQL..."
sudo docker run -d -p 3306:3306 --name ByteGuard -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8.0
echo "Container MySQL criado e em execução!"
# Executar o script SQL dentro do container MySQL
echo "Executando o script SQL dentro do container MySQL..."
sleep 15
sudo docker exec -i ByteGuard mysql -u root -paluno < /home/ubuntu/docker-scripts-repo/script.sql
echo "Script SQL executado com sucesso!"
# Dar permissão de execução ao arquivo java.sh
echo "Dando permissão de execução ao arquivo install_java.sh..."
chmod +x java.sh
echo "Permissão concedida com sucesso!"
# Executar o arquivo java.sh
echo "Executando o arquivo install_java.sh..."
./java.sh
echo "Arquivo install_java.sh executado com sucesso!"
