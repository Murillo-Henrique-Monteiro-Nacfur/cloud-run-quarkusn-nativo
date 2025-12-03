# Estágio 1: Build Nativo com a imagem vegardit, que inclui Maven e GraalVM
FROM vegardit/graalvm-maven:latest-java21 as build

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Executa a compilação nativa para gerar o executável *-runner
RUN mvn package -Pnative -DskipTests

# Estágio 2: Imagem final com Distroless - super leve e segura
FROM gcr.io/distroless/base-debian12

WORKDIR /work/

# Copia apenas o executável nativo do estágio de build.
# As permissões de execução são preservadas.
COPY --from=build /app/target/*-runner /work/application

EXPOSE 8080

# A imagem distroless já usa um usuário não-root.
# O ENTRYPOINT aponta para o nosso executável.
ENTRYPOINT ["/work/application"]
