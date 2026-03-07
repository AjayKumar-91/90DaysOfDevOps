from flask import Flask, render_template
import mysql.connector
import redis
import os

app = Flask(__name__)

def check_mysql():
    try:
        conn = mysql.connector.connect(
            host="database",
            user="mysql",
            password="Test@123",
            database="mydb"
        )
        conn.close()
        return "Connected"
    except:
        return "Not Connected"

def check_redis():
    try:
        r = redis.Redis(host="redis", port=6379)
        r.ping()
        return "Connected"
    except:
        return "Not Connected"

@app.route("/")
def home():
    mysql_status = check_mysql()
    redis_status = check_redis()

    return render_template(
        "index.html",
        mysql_status=mysql_status,
        redis_status=redis_status
    )

@app.route("/health")
def health():
    return {
        "app": "running",
        "mysql": check_mysql(),
        "redis": check_redis()
    }

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)