FROM ubuntu:latest AS development
RUN apt-get update && apt-get install -y --no-install-recommends \
  default-jdk-headless maven git && rm -rf /var/lib/apt/lists/*
WORKDIR /code
COPY . /code
RUN mvn clean package

FROM tomcat:9
COPY --from=development /code/target/sparkjava-hello-world-1.0.war  /usr/local/tomcat/webapps/

