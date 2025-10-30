import time
from datetime import datetime

while True:
    print(f"Current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}", flush=True)
    time.sleep(30)
