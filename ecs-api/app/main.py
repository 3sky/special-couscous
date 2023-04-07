from datetime import datetime
from fastapi import FastAPI
import socket

app = FastAPI()


@app.get("/")
async def root():
    fqdn: str = socket.getfqdn()
    now: str = str(datetime.now())
    return {"Message": "Hello, world!", "Date": now, "Host": fqdn}


@app.get("/healtz", status_code=200)
async def root():
    return {"Status": "Alive"}
