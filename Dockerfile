# Estágio 1: Build Nativo com a imagem correta do Quarkus
# Esta imagem contém Maven, GraalVM e todas as libs nativas necessárias.
FROM quay.io/quarkus/ubi-quarkus-mandrel-builder-image:jdk-21 as build
WORKDIR /app
COPY pom.xml .
COPY src ./src
# O diretório de usuário na imagem é /home/quarkus, então ajustamos o cache do Maven
RUN mvn package -Pnative -DskipTests -Dmaven.repo.local=/app/.m2/repository

# Comando de depuração para verificar o artefato gerado
RUN ls -l /app/target

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
