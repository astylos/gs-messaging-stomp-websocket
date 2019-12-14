FROM openjdk:8 as buildenv
COPY complete /usr/src/myapp
WORKDIR /usr/src/myapp
RUN ./gradlew bootJar

FROM openjdk:8
WORKDIR /usr/src/myapp
COPY --from=buildenv /usr/src/myapp/build/libs/*.jar /usr/src/myapp
EXPOSE 8080
CMD java -jar ./gs-messaging-stomp-websocket-0.1.0.jar
