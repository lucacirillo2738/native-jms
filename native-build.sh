#!/usr/bin/env bash

MAINCLASS=com.example.springboot.Application
FATJARNAME=spring-boot-complete-0.0.1-SNAPSHOT
GRAALVM_HOME=/usr/lib/jvm/graalvm-ee-java11-22.0.0.2
AOTCONFDIR=target/classes/META-INF/native-image/org.springframework.aot/spring-aot/

export GRAALVM_HOME=$GRAALVM_HOME


echo "[-->] Cleaning target directory & creating new one"
rm -rf target
mkdir -p target/native-image

mkdir -p "$AOTCONFDIR"

mvn package -DskipTests

echo "[-->] Expanding the Spring Boot fat jar"
JAR="$FATJARNAME.jar"
cd target/native-image
jar -xvf ../$JAR >/dev/null 2>&1
cp -R META-INF BOOT-INF/classes

echo "[-->] Set the classpath to the contents of the fat jar (where the libs contain the Spring Graal AutomaticFeature)"
LIBPATH=`find BOOT-INF/lib | tr '\n' ':'`
CP=BOOT-INF/classes:$LIBPATH$JAR

GRAALVM_VERSION=`$GRAALVM_HOME/bin/native-image --version`
echo "[-->] Compiling Spring Boot App '$ARTIFACT' with $GRAALVM_VERSION"


time $GRAALVM_HOME/bin/native-image \
  -J-Xmx10G \
  -H:Name=$FATJARNAME \
  -H:+ReportExceptionStackTraces \
  -cp $CP \
  -H:Class=$MAINCLASS \
  --allow-incomplete-classpath \
  --report-unsupported-elements-at-runtime \
  --initialize-at-build-time=org.springframework.util.unit.DataSize \
  --verbose \
  --no-fallback;
  
