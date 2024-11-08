# Use the official OpenJDK 17 image as the base image
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the Maven wrapper and build files into the container
COPY .mvn/ .mvn
COPY mvnw .
COPY pom.xml .

# Copy the source code into the container
COPY src ./src

# Clean and build the application to ensure a fresh JAR file
RUN ./mvnw clean package -DskipTests

# List contents to verify the JAR file is present and to check the timestamp
RUN ls -l /app/target

# Make the JAR file executable (only needed if it’s not already set as executable)
RUN chmod +x /app/target/spring-petclinic-*.jar

# Expose the port on which the app runs
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/target/spring-petclinic-3.3.0-SNAPSHOT.jar"]
