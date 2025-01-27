# STAGE 1: Build the application using Maven
FROM maven:3.6.3-openjdk-8 AS builder

WORKDIR /app

COPY . /app

# build the project
RUN mvn clean package

# install netcat
RUN apt-get update && apt-get install -y netcat && apt-get clean


# STAGE 2: Create a lightweight runtime image with JRE only
FROM openjdk:8-jre-alpine

EXPOSE 8080

WORKDIR /app

# Copy only the compiled application files from the builder stage
COPY --from=builder /app/target/lavagna-jetty-console.war /app
COPY --from=builder /app/target/lavagna/help /app/help

COPY entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
