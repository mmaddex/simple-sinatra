import time
from datetime import datetime

def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

while True:
    print(f"Current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}", flush=True)
    
    # Do some actual work
    result = fibonacci(25)
    print(f"Fibonacci(25) = {result}", flush=True)
    
    time.sleep(5)
