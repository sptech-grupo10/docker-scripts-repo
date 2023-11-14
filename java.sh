jar_url = "https://github.com/sptech-grupo10/Java/blob/main/target/jar-byteguard-1.0-SNAPSHOT.jar"

jar_nome="jar-byteguard-1.0-SNAPSHOT.jar

./install_java.sh

java -jar "$jar_nome"

if[$? -eq 0]; then
    echo "Executando JAR"
else
    echo "Erro ao executar JAR"
fi