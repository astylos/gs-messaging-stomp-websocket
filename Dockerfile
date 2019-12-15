FROM openjdk:8 as buildenv

# copy and run gradlew to get gradle installed, then src code changes don't
# trigger pulling gradle down again
COPY complete/gradle /usr/src/myapp/gradle
COPY complete/gradlew /usr/src/myapp/
WORKDIR /usr/src/myapp
RUN ./gradlew --no-daemon

COPY complete /usr/src/myapp
RUN ./gradlew --no-daemon bootJar

FROM openjdk:8
WORKDIR /usr/src/myapp
COPY --from=buildenv /usr/src/myapp/build/libs/*.jar /usr/src/myapp
EXPOSE 8080
CMD java -jar ./gs-messaging-stomp-websocket-0.1.0.jar
