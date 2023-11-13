# Use a imagem oficial do MySQL
FROM mysql:5.7

# Copie o arquivo SQL para dentro do container
COPY script.sql /docker-entrypoint-initdb.d/

# Defina a variável de ambiente para a senha do root
ENV MYSQL_ROOT_PASSWORD=aluno

# Exponha a porta 3306 para acesso externo
EXPOSE 3306
