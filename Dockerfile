# Build WAR using Maven
FROM maven:3.9.4-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Deploy to Tomcat
FROM tomcat:9.0-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=build /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

# Copy TiDB CA certificate into the container (for SSL)
COPY src/main/resources/tidb-ca.pem /certs/tidb-ca.pem

EXPOSE 8080
CMD ["catalina.sh", "run"]
