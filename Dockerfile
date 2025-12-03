# Estágio 1: Build Nativo com a imagem vegardit, que inclui Maven e GraalVM
FROM vegardit/graalvm-maven:latest-java21 as build

WORKDIR /app
COPY pom.xml .
COPY src ./src

# Executa a compilação nativa para gerar o executável *-runner
RUN mvn package -Pnative -DskipTests

# Estágio 2: Imagem final com Distroless - com bibliotecas C comuns
# Usamos a imagem 'cc' que inclui bibliotecas essenciais como a libz.so.1
FROM gcr.io/distroless/cc-debian12

WORKDIR /work/

# Copia apenas o executável nativo do estágio de build.
COPY --from=build /app/target/*-runner /work/application

EXPOSE 8080

# A imagem distroless já usa um usuário não-root.
ENTRYPOINT ["/work/application"]
