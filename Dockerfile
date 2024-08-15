FROM openjdk:11-jre-slim

WORKDIR /app

COPY myapp.jar /app/myapp.jar

EXPOSE 8080

CMD ["java", "-jar", "myapp.jar"]
