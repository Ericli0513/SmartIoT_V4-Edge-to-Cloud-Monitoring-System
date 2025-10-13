import paho.mqtt.client as mqtt
import json
import time
import random
import threading
import os

# ====== AWS IoT Core 設定 ======
AWS_ENDPOINT = "ae85p1z5tp08t-ats.iot.ap-northeast-1.amazonaws.com"
AWS_PORT = 8883
CERT_DIR = r"C:\Users\123\Downloads\AWS_certificate"

CA_PATH   = os.path.join(CERT_DIR, "AmazonRootCA1.pem")
CERT_PATH = os.path.join(CERT_DIR, "device1-certificate.pem.crt")
KEY_PATH  = os.path.join(CERT_DIR, "device1-private.pem.key")

#.......