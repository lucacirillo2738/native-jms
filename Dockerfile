FROM ghcr.io/graalvm/jdk:latest 

# Add Spring Boot Native app spring-boot-graal to Container
COPY "/target/spring-boot-complete" spring-boot-complete
 
# Fire up our Spring Boot Native app by default
CMD [ "sh", "-c", "./spring-boot-complete" ]