# Test environment:
- GraalVM version: graalvm-ee-java11-22.0.0.2
- JDK java-8-openjdk-amd64
- Maven:
	- Apache Maven 3.6.3
	- Java version: 1.8.0_312
- OS: KDE neon Unstable Edition
- KDE Plasma Version: 5.23.80
- KDE Frameworks Version: 5.90.0
- Qt Version: 5.15.3
- Kernel Version: 5.11.0-44-generic (64-bit)
- Graphics Platform: X11
- Processors: 8 × Intel® Core™ i7-7700HQ CPU @ 2.80GHz
- Memory: 15,6 GiB of RAM
- Graphics Processor: NV136


# Steps to reproduce the bug:
- set java and maven version as explained above.
- edit native-build.sh and set the path in GRAALVM_HOME. I've used graalvm-ee-java11-22.0.0.2
- run native-build.sh it will execute 'mvn package -DskipTests' and 'native-image' command that will produce the native image named 'spring-boot-complete-0.0.1-SNAPSHOT' in path 'native-jms/target/native-image/'
-  run 'spring-boot-complete-0.0.1-SNAPSHOT' native image
- check error in log during startup:
		'Invalid declaration of container type [org.springframework.jms.annotation.JmsListeners] for repeatable annotation [org.springframework.jms.annotation.JmsListener]; nested exception is java.lang.NoSuchMethodException: No value method found'
- same exception occurs also if you use 'jakarta.jms-api', 'jakarta.json-api', 'spring-jms' and 'artemis-jms-client' instead of using 'spring-boot-starter-artemis'

# Success scenario:
- edit pom.xml deleting or commenting 'spring-boot-starter-artemis' dependency (or 'jakarta.jms-api', 'jakarta.json-api', 'spring-jms' and 'artemis-jms-client' dependencies if you haven't used spring-boot-starter-artemis)
- set java and maven version as explained above.
- edit native-build.sh and set the path in GRAALVM_HOME. I've used graalvm-ee-java11-22.0.0.2
- run native-build.sh it will execute 'mvn package -DskipTests' and 'native-image' command that will produce the native image named 'spring-boot-complete-0.0.1-SNAPSHOT' in path 'native-jms/target/native-image/'
-  run 'spring-boot-complete-0.0.1-SNAPSHOT' native image
_  check no error in log during startup and try to connect via browser to http://localhost:8080/ should be appear "Greetings from Spring Boot!"
