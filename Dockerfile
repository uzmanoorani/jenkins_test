FROM openjdk:11-jre-slim

WORKDIR /app

COPY crud-tuto-1.0.jar /app/crud-tuto.jar

EXPOSE 8080

CMD ["java", "-jar", "myapp.jar"]
