from flask import Flask, render_template_string
import os

app = Flask(__name__)

TEMPLATE = """
<h1>PNB Console</h1>
<p>Status: {{status}}</p>
<a href="/start">Start PNB Connect</a> |
<a href="/stop">Stop PNB Connect</a> |
<a href="/logs">View Logs</a>
"""

@app.route("/")
def index():
    status = os.popen("docker ps --filter name=pnb_connect").read()
    return render_template_string(TEMPLATE, status=status)

@app.route("/start")
def start():
    os.system("docker start pnb_connect")
    return "Started PNB Connect"

@app.route("/stop")
def stop():
    os.system("docker stop pnb_connect")
    return "Stopped PNB Connect"

@app.route("/logs")
def logs():
    logs = os.popen("docker logs pnb_connect --tail 50").read()
    return f"<pre>{logs}</pre>"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
