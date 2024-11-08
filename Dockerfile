# Use the official OpenJDK 17 image as the base image
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Maven build files into the container
COPY .mvn/ .mvn
COPY mvnw .
COPY pom.xml .

# Copy source code into the container
COPY src ./src

# Build the application
RUN ./mvnw install -DskipTests

# List contents to verify JAR is present
RUN ls -l /app/target

# Expose the port on which the app runs
EXPOSE 8080


RUN chmod +x /app/target/spring-petclinic-*.jar


# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/target/spring-petclinic-*.jar"]
