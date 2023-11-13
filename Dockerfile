# está usando a imagem oficial do Java como imagem base (OpenJDK 11)
FROM openjdk:11
WORKDIR /app
COPY . /app
RUN javac Main.java
CMD ["java", "Main"]
