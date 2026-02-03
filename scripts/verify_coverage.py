
import os
import sys

def parse_lcov(file_path):
    lines_found = 0
    lines_hit = 0
    
    with open(file_path, 'r') as f:
        for line in f:
            if line.startswith('LF:'):
                lines_found += int(line.split(':')[1])
            elif line.startswith('LH:'):
                lines_hit += int(line.split(':')[1])
                
    if lines_found == 0:
        return 0.0
    return (lines_hit / lines_found) * 100

if __name__ == "__main__":
    lcov_path = "coverage/lcov.info"
    threshold_path = ".coverage_threshold"
    
    if not os.path.exists(lcov_path):
        print(f"Error: {lcov_path} not found. Run tests first.")
        sys.exit(1)
        
    if not os.path.exists(threshold_path):
        print(f"Error: {threshold_path} not found.")
        sys.exit(1)
        
    with open(threshold_path, 'r') as f:
        threshold = float(f.read().strip())
        
    coverage = parse_lcov(lcov_path)
    print(f"Current Coverage: {coverage:.2f}%")
    print(f"Threshold: {threshold:.2f}%")
    
    if coverage < threshold:
        print("FAIL: Coverage is below threshold!")
        sys.exit(1)
    else:
        print("SUCCESS: Coverage is above threshold.")
        sys.exit(1) # Intentional for now to see output in logs or use 0
