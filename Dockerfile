# Use a imagem base do Java 21
FROM eclipse-temurin:21-jre

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /work/

# Copie o JAR executável do Quarkus (o "runner" JAR) para dentro do contêiner
# O * é usado para corresponder a qualquer nome de versão
COPY target/*-runner.jar app.jar

# Defina a porta em que a aplicação irá rodar
EXPOSE 8080

# O comando para iniciar a aplicação quando o contêiner for executado
CMD ["java", "-jar", "app.jar"]
