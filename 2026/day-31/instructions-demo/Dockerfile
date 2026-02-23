FROM ubuntu:latest

WORKDIR /app

COPY . .

RUN apt update && apt install -y curl

EXPOSE 9090

CMD ["cat", "app.txt"]
