# Use --platform para garantir a compilação para linux/amd64, a arquitetura do Cloud Run
FROM --platform=linux/amd64 maven:3.9.6-eclipse-temurin-21 as build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -Pnative -DskipTests
# Adicionando um comando para listar os arquivos e depurar o nome do artefato
RUN ls -l /app/target

# Use a mesma plataforma para a imagem final
FROM --platform=linux/amd64 registry.access.redhat.com/ubi9/ubi-minimal:9.6
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
# Copia o executável nativo (que não tem extensão .jar)
COPY --from=build --chown=1001:root /app/target/*-runner /work/application
RUN chmod +x /work/application

EXPOSE 8080
USER 1001

# O executável nativo do Quarkus usa automaticamente a variável de ambiente PORT do Cloud Run
ENTRYPOINT ["./application"]
