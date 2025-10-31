import time
import tracemalloc
from datetime import datetime

def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

def do_work():
    # Create some memory load
    data = [i for i in range(1000000)]  # 1 million integers
    result = fibonacci(25)
    print(f"Fibonacci(25) = {result}", flush=True)
    return data

def print_memory_stats():
    """Print current memory usage"""
    current, peak = tracemalloc.get_traced_memory()
    print(f"\n{'='*60}")
    print(f"Current memory: {current / 1024 / 1024:.2f} MB")
    print(f"Peak memory:    {peak / 1024 / 1024:.2f} MB")
    print(f"{'='*60}\n")

def main():
    # Start tracking memory
    tracemalloc.start()
    
    for i in range(5):
        print(f"Current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}", flush=True)
        data = do_work()
        print_memory_stats()
        time.sleep(2)
    
    # Get top memory consumers
    print("\nTop 10 memory allocations:")
    print("="*60)
    snapshot = tracemalloc.take_snapshot()
    top_stats = snapshot.statistics('lineno')
    
    for stat in top_stats[:10]:
        print(stat)
    
    tracemalloc.stop()

if __name__ == '__main__':
    main()
