# Use Java 8 base image
FROM eclipse-temurin:8-jdk

# Set working directory
WORKDIR /app

# Copy source code
COPY src/ ./src/

# Compile Java app
RUN mkdir bin && javac -d bin src/Main.java

EXPOSE 8080

# Command to run app
CMD ["java", "-cp", "bin", "Main"]
