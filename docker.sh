echo "Instalando o docker: "
sudo apt install docker.io

echo "Docker instalado."

echo "Iniciando docker: "
sudo systemctl start docker
sudo systemctl enable docker

echo "Baixando a imagem MySQL: "
sudo docker pull mysql:5.7
echo "Imagem do MySQL 5.7 baixada."

echo "Criando e executando o container MySQL: "
sudo docker run -d -p 3306:3306 --name magister -e "MYSQL_ROOT_PASSWORD=aluno" mysql:5.7
echo "Container MySQL criado."

echo "Executando o script SQL dentro do container MySQL..."
sleep 15
sudo docker exec -i magister mysql -u root -paluno < /home/ubuntu/docker-scripts-repo/script.sql

echo "Script SQL executado."

echo "Dando permissão de execução ao arquivo java.sh: 
chmod +x java.sh
echo "Permissão concedida."

./java.sh