FROM openjdk:8-jdk-alpine
LABEL dev="Zied KHELIFI"
EXPOSE 8080
WORKDIR /app
COPY target/employeecare.war /app/employeecare.war
ENTRYPOINT ["java","-jar","/app/employeecare.war","-Dspring.config.location=config/application.yaml"]
COPY VERSION /