
import re
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
    if len(sys.argv) < 2:
        print("Usage: python calculate_coverage.py path/to/lcov.info")
        sys.exit(1)
    
    coverage = parse_lcov(sys.argv[1])
    print(f"Total Coverage: {coverage:.2f}%")
