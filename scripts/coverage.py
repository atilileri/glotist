import os
import sys
import subprocess

def run_tests():
    print("Running tests with coverage...")
    # Use shell=True on Windows to resolve 'flutter' from PATH correctly
    result = subprocess.run(["flutter", "test", "--coverage"], shell=(os.name == "nt"))
    if result.returncode != 0:
        print("\nTests failed! Please fix failing tests before checking coverage.")
        sys.exit(result.returncode)

def parse_lcov(file_path):
    if not os.path.exists(file_path):
        print(f"Error: {file_path} not found. Did the tests generate it?")
        sys.exit(1)
        
    file_stats = {}
    total_lines_found = 0
    total_lines_hit = 0
    total_funcs_found = 0
    total_funcs_hit = 0

    current_file = None
    current_funcs = {}
    current_lines_found = 0
    current_lines_hit = 0
    
    with open(file_path, 'r', encoding='utf-8') as f:
        for line in f:
            line = line.strip()
            if line.startswith('SF:'):
                current_file = line[3:]
                current_funcs = {}
                current_lines_found = 0
                current_lines_hit = 0
            elif line.startswith('FN:'):
                parts = line[3:].split(',')
                if len(parts) >= 2:
                    current_funcs[parts[1]] = {'found': True, 'hit': 0}
            elif line.startswith('FNDA:'):
                parts = line[5:].split(',')
                if len(parts) >= 2:
                    try:
                        hits = int(parts[0])
                        name = parts[1]
                        if name in current_funcs:
                            current_funcs[name]['hit'] += hits
                    except ValueError:
                        pass
            elif line.startswith('LF:'):
                current_lines_found = int(line[3:])
            elif line.startswith('LH:'):
                current_lines_hit = int(line[3:])
            elif line == 'end_of_record':
                if current_file:
                    file_stats[current_file] = {
                        'lines_found': current_lines_found,
                        'lines_hit': current_lines_hit,
                        'functions': current_funcs
                    }
                    total_lines_found += current_lines_found
                    total_lines_hit += current_lines_hit
                    
                    for fn, data in current_funcs.items():
                        total_funcs_found += 1
                        if data['hit'] > 0:
                            total_funcs_hit += 1
                
                current_file = None

    return file_stats, total_lines_found, total_lines_hit, total_funcs_found, total_funcs_hit

def print_coverage_report(file_stats, total_lf, total_lh):
    # Calculate max width needed for file names
    max_file_len = max([len(f) for f in file_stats.keys()] + [45])
    table_width = max_file_len + 15 + 15 + 10 # File + Coverage + Lines + Missing
    
    separator = "=" * table_width
    print("\n" + separator)
    print(f"{'File':<{max_file_len}} | {'Coverage':<10} | {'Lines':<12} | {'Missing':<8}")
    print(separator)
    
    for file, stats in sorted(file_stats.items()):
        lf = stats['lines_found']
        lh = stats['lines_hit']
        missing = lf - lh
        cov = (lh / lf * 100) if lf > 0 else 100.0
        
        lines_str = f"{lh}/{lf}"
        print(f"{file:<{max_file_len}} | {cov:>8.2f}% | {lines_str:>12} | {missing:>7}")
        
    print(separator)
    total_cov = (total_lh / total_lf * 100) if total_lf > 0 else 0.0
    total_lines_str = f"{total_lh}/{total_lf}"
    total_missing = total_lf - total_lh
    print(f"{'TOTAL':<{max_file_len}} | {total_cov:>8.2f}% | {total_lines_str:>12} | {total_missing:>7}")
    print(separator + "\n")
    return total_cov

if __name__ == "__main__":
    run_tests()
    
    lcov_path = "coverage/lcov.info"
    threshold_path = ".coverage_threshold"
    
    print("\nParsing coverage data...\n")
    file_stats, tot_lf, tot_lh, tot_ff, tot_fh = parse_lcov(lcov_path)
    total_cov = print_coverage_report(file_stats, tot_lf, tot_lh)
    
    print(f"Total Lines Hit     : {tot_lh}/{tot_lf}")
    print(f"Total Functions Hit : {tot_fh}/{tot_ff}")
    print(f"Current Coverage    : {total_cov:.2f}%")
    
    if os.path.exists(threshold_path):
        with open(threshold_path, 'r') as f:
            try:
                threshold = float(f.read().strip())
                print(f"Threshold Required  : {threshold:.2f}%")
                if total_cov < threshold:
                    print("\n❌ FAIL: Coverage is below threshold!")
                    sys.exit(1)
                else:
                    print("\n✅ SUCCESS: Coverage is above threshold.")
            except ValueError:
                print(f"\nWarning: Invalid threshold found in {threshold_path}.")
    else:
        print(f"\nWarning: '{threshold_path}' not found. Threshold check skipped.")
        
    sys.exit(0)
