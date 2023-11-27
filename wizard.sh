#!/bin/sh

# Mensagem informativa sobre a instalação do Docker
chmod +x wizard.sh
chmod +x script.sql
chmod +x docker.sh
echo "Permissão para iniciar instalação do Docker. S/N"
read resposta
if [ "$resposta" = "S" ] || [ "$resposta" = "s" ]; then
    echo "Instalando o Docker..."
    sudo apt install docker.io
    echo "Docker instalado com sucesso!"
    
    echo "Aperte S para continuar ou N para encerrar o processo"
    read resposta2
    if [ "$resposta2" = "S" ] || [ "$resposta2" = "s" ]; then
        # Iniciar o serviço do Docker
        echo "Iniciando o serviço do Docker e Habilitando..."
        sudo systemctl start docker
        sudo systemctl enable docker
    else
        echo "Docker não inicializado"
        echo "Finalizando processo"
        exit 1
    fi
else
    echo "Docker não instalado"
    echo "Finalizando processo"
    exit 1
fi

# Permissão para iniciar instalação do MySQL
echo "Permissão para iniciar instalação do MySQL. S/N"
read resposta3
if [ "$resposta3" = "S" ] || [ "$resposta3" = "s" ]; then
    # Baixar a imagem do MySQL 8.0
    echo "Baixando a imagem do MySQL 8.0..."
    sudo docker pull mysql:8.0
    echo "Imagem do MySQL 8.0 baixada com sucesso!"

    # Criar e executar o container MySQL
    echo "Criando e executando o container MySQL..."
    sudo docker run -d -p 3306:3306 --name ByteGuard -e "MYSQL_ROOT_PASSWORD=aluno" mysql:8.0
    echo "Container MySQL criado e em execução!"

    # Executar o script SQL dentro do container MySQL
    echo "Executando o script SQL dentro do container MySQL..."
    sleep 15
    sudo docker exec -i ByteGuard mysql -u root -paluno < /home/ubuntu/docker-scripts-repo/script.sql
    sudo docker exec -i ByteGuard mysql -u root -paluno -e "CREATE USER 'aluno'@'%' IDENTIFIED BY 'aluno'; GRANT ALL PRIVILEGES ON *.* TO 'aluno'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
    echo "Script SQL executado com sucesso!"

    # Permissão para instalar o Java
    echo "Permissão para instalar o Java. S/N"
    read resposta4
    if [ "$resposta4" = "S" ] || [ "$resposta4" = "s" ]; then
        # Dar permissão de execução ao arquivo java.sh
        echo "Dando permissão de execução ao arquivo java.sh..."
        chmod +x java.sh
        echo "Permissão concedida com sucesso!"

        # Executar o arquivo java.sh
        echo "Executando o arquivo java.sh..."
        ./java.sh
        echo "Arquivo java.sh executado com sucesso!"
    else
        echo "Java não instalado"
        echo "Finalizando processo"
        exit 1
    fi
else
    echo "Container MySQL não criado!"
    echo "Finalizando processo"
    exit 1
fi
