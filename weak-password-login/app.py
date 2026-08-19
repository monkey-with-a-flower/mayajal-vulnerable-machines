from __future__ import annotations

import logging
import secrets
from datetime import datetime, timezone
from pathlib import Path

from flask import Flask, redirect, render_template_string, request, session

app = Flask(__name__)
app.secret_key = "mayajal-demo-secret"
logging.basicConfig(level=logging.INFO, format="%(message)s")

passwords = tuple(line.strip() for line in Path("/app/passwords.txt").read_text().splitlines() if line.strip())
if len(passwords) != 1000 or len(set(passwords)) != 1000:
    raise RuntimeError("Password dictionary must contain exactly 1000 unique entries.")
USERS = {"admin": secrets.choice(passwords)}

LOGIN_TEMPLATE = """
<!doctype html><html lang="en"><head><meta charset="utf-8"><title>Northstar Payroll Login</title>
<style>body{font-family:Arial;background:#f3f7f4;color:#17231f}main{max-width:420px;margin:10vh auto;background:white;padding:28px}label{display:block;margin-top:16px}input,button{width:100%;min-height:42px;margin-top:6px}</style>
</head><body><main><h1>Northstar Payroll</h1>{% if error %}<p>{{ error }}</p>{% endif %}
<form method="post"><label>Username<input name="username"></label><label>Password<input name="password" type="password"></label><button>Sign in</button></form>
</main></body></html>
"""

def log_event(event: str, outcome: str, username: str) -> None:
    app.logger.info(
        "mayajal_weak_password_login event=%s outcome=%s username=%s source_ip=%s timestamp=%s",
        event,
        outcome,
        username,
        request.remote_addr or "unknown",
        datetime.now(timezone.utc).isoformat(),
    )

@app.get("/")
def index():
    return redirect("/dashboard" if session.get("username") else "/login")

@app.route("/login", methods=["GET", "POST"])
def login():
    if request.method == "GET":
        return render_template_string(LOGIN_TEMPLATE, error="")
    username, password = request.form.get("username", ""), request.form.get("password", "")
    if USERS.get(username) == password:
        session["username"] = username
        log_event("authentication", "success", username)
        return redirect("/dashboard")
    log_event("authentication", "failure", username)
    return render_template_string(LOGIN_TEMPLATE, error="Invalid username or password."), 401

@app.get("/dashboard")
def dashboard():
    if not session.get("username"):
        return redirect("/login")
    log_event("protected_objective_access", "success", session["username"])
    return {"message": "Welcome to Northstar Payroll.", "user": session["username"], "flag": "MAYAJAL{weak_password_payroll_access}"}

@app.get("/health")
def health():
    return {"status": "ok"}

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
