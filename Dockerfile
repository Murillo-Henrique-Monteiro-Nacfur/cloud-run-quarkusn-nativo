FROM maven:3.9.6-eclipse-temurin-21 as build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package -Pnative -DskipTests
# Debug: Listar conteúdo do target para verificar se o arquivo foi gerado
RUN ls -la /app/target/

FROM registry.access.redhat.com/ubi9/ubi-minimal:9.6
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work
COPY --from=build --chown=1001:root /app/target/*-runner.jar /work/application
RUN chmod +x /work/application

EXPOSE 8080
USER 1001

# Cloud Run passa PORT automaticamente, Quarkus usa isso por padrão
ENTRYPOINT ["./application"]
