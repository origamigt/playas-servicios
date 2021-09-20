FROM adoptopenjdk/openjdk8:alpine-jre 
COPY /target/catastro-0.0.1-SNAPSHOT.jar /opt/app/
WORKDIR /opt/app
RUN sh -c 'touch catastro-0.0.1-SNAPSHOT.jar'

ENTRYPOINT ["java","-Dspring.profiles.active=dev","-jar","catastro-0.0.1-SNAPSHOT.jar"]