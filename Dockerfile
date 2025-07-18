FROM eclipse-temurin:17-jdk

WORKDIR /app
COPY target/demo-1.0.0-jar-with-dependencies.jar app.jar

CMD ["java", "-jar", "app.jar"]

