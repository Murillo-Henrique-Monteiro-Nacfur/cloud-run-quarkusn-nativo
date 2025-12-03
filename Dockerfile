# Estágio 1: Build Nativo usando uma imagem que contém Maven e GraalVM
FROM vegardit/graalvm-maven:latest-java21 as build

WORKDIR /app
COPY pom.xml .
COPY src ./src

# O comando 'mvn' está disponível globalmente nesta imagem
RUN mvn package -Pnative -DskipTests

# Estágio 2: Imagem final, leve e otimizada
FROM registry.access.redhat.com/ubi9/ubi-minimal:9.6
WORKDIR /work/
RUN chown 1001 /work \
    && chmod "g+rwX" /work \
    && chown 1001:root /work

# Copia o executável nativo (sem a extensão .jar) do estágio de build
COPY --from=build --chown=1001:root /app/target/*-runner /work/application
RUN chmod +x /work/application

EXPOSE 8080
USER 1001

# O executável nativo do Quarkus usa automaticamente a variável de ambiente PORT
ENTRYPOINT ["./application"]
