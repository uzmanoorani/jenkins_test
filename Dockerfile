# Use a base image
FROM openjdk:11-jre-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the application's jar file into the container
COPY myapp.jar /app/myapp.jar

# Expose the port the app runs on
EXPOSE 8080

# Define the command to run the application
CMD ["java", "-jar", "myapp.jar"]
