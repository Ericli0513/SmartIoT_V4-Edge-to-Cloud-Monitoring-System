from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import FileResponse
from pydantic import BaseModel
import paho.mqtt.client as mqtt
import json
import threading
import uvicorn

app = FastAPI()

# CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

#.......
devices_status = {
    f"device{i+1}": {f"led{j+1}": 1 for j in range(NUM_LEDS)}
    for i in range(NUM_DEVICES)
}

dht22_data = {
    f"device{i+1}": {"temperature":0, "humidity":0, "time":""}
    for i in range(NUM_DEVICES)
}


class DevicesCommand(BaseModel):
    devices: dict

#.......

@app.get("/status")
def get_status():
    return devices_status

@app.get("/dht22")
def get_dht22():
    return dht22_data
    
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)