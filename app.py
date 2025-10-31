import time
import cProfile
import pstats
from datetime import datetime
from io import StringIO

def fibonacci(n):
    """Calculate fibonacci recursively (intentionally slow)"""
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

def do_work():
    """Main work function"""
    print(f"Current time: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}", flush=True)
    result = fibonacci(30)
    print(f"Fibonacci(30) = {result}", flush=True)

def main():
    """Run for a limited time, then print profile"""
    iterations = 5  # Run 5 times then stop
    
    for i in range(iterations):
        do_work()
        time.sleep(2)
        print(f"Iteration {i+1}/{iterations} complete\n", flush=True)

if __name__ == '__main__':
    profiler = cProfile.Profile()
    profiler.enable()
    
    try:
        main()
    except KeyboardInterrupt:
        print("\nStopped by user")
    finally:
        profiler.disable()
        
        # Print profiling results
        print("\n" + "="*80)
        print("PROFILING RESULTS")
        print("="*80 + "\n")
        
        s = StringIO()
        stats = pstats.Stats(profiler, stream=s)
        stats.sort_stats('cumulative')
        stats.print_stats(20)  # Top 20 functions
        
        print(s.getvalue())
