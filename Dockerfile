# STEP 1: Build WAR using Maven
FROM maven:3.9.6-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# STEP 2: Deploy WAR in Jetty
FROM jetty:11.0.15-jdk17
WORKDIR /var/lib/jetty/webapps

# Copy WAR into Jetty's ROOT context
COPY --from=build /app/target/Attendance_Management_System-1.0-SNAPSHOT.war ./ROOT.war

# Expose Jetty default port
EXPOSE 8080

# ✅ No need to override CMD, use Jetty's default entrypoint