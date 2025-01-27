FROM maven:3.6.3-openjdk-8

EXPOSE 8080

# install nc
RUN apt-get update && apt-get install -y netcat && apt-get clean

WORKDIR /app
COPY . /app

# build the application
RUN mvn clean install

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
