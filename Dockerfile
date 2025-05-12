# Use OpenJDK 11 as the base image
FROM openjdk:11-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled JAR file into the container
COPY target/JavaWeb3.jar /app/JavaWeb3.jar

# Expose port 8080 to the outside world
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "JavaWeb3.jar"]
