#!/bin/bash

# Construir o contêiner do banco de dados
echo "Construindo o contêiner do banco de dados..."
cd banco-de-dados
docker build -t meu-banco-de-dados .
cd ..

# Executar o contêiner do banco de dados
echo "Executando o contêiner do banco de dados..."
docker run -d -p 3306:3306 --name meu-container-banco meu-banco-de-dados

# Construir o contêiner da aplicação Java
echo "Construindo o contêiner da aplicação Java..."
cd aplicacao-java
docker build -t minha-aplicacao-java .
cd ..

# Executar o contêiner da aplicação Java
echo "Executando o contêiner da aplicação Java..."
docker run -d --name meu-container-java minha-aplicacao-java


public class ExpurgoEventosSiengeSchedulable 
criar dados de teste
for(integer i = 0;i 1000; I++)

eventos new add Evento sienge
