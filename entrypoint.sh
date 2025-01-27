#!/bin/bash

# Wait for MySQL to be ready
while ! nc -z db 3306; do
  echo "Waiting for MySQL..."
  sleep 5
done

# Start Lavagna application
java -Xms64m -Xmx128m \
  -Ddatasource.dialect=${DB_DIALECT} \
  -Ddatasource.url=${DB_URL} \
  -Ddatasource.username=${DB_USER} \
  -Ddatasource.password=${DB_PASS} \
  -Dspring.profiles.active=${SPRING_PROFILE} \
  -jar /app/target/lavagna-jetty-console.war
