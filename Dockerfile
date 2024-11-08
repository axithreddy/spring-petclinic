# Use the official OpenJDK 17 image as the base image
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper and related files into the container
COPY .mvn/ .mvn
COPY mvnw .
COPY pom.xml .

# Download dependencies to optimize build cache
RUN ./mvnw dependency:go-offline -B

# Copy the source code into the container
COPY src ./src

# Build the application
RUN ./mvnw package -DskipTests

# Expose the port on which the app runs
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/target/spring-petclinic-*.jar"]