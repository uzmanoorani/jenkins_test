FROM openjdk:17-slim

WORKDIR /app

COPY crud-tuto-1.0.jar /app/crud-tuto.jar

EXPOSE 8080

ENTRYPOINT ["java"]

CMD ["-jar", "myapp.jar"]

#CMD ["java", "-jar", "myapp.jar"]
