# Usar imagem oficial Maven para build com Java 21
FROM maven:3.9.4-eclipse-temurin-21 AS build

WORKDIR /app
COPY . .

# Build do projeto, gerando o JAR (pulando testes)
RUN mvn clean package -DskipTests

# Imagem leve para rodar a aplicação (Java 21 JRE Alpine)
FROM eclipse-temurin:21-jre-alpine

WORKDIR /app

# Copiar o JAR gerado da etapa de build
COPY --from=build /app/target/aquela-empada-0.0.1-SNAPSHOT.jar app.jar

# Expor a porta 8080 (Spring Boot padrão)
EXPOSE 8080

# Comando para iniciar o aplicativo
ENTRYPOINT ["java", "-jar", "app.jar"]
