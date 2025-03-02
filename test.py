import socket
import os

GREEN = '\033[92m'
RED = '\033[91m'
RESET = '\033[0m'

sources_list_file = '/etc/apt/sources.list'

def test_file_exists(file_path):
    return os.path.isfile(file_path)

if test_file_exists(sources_list_file):
    print(f"Test {GREEN}passed{RESET}: The file was found.")
else:
    print(f"Test {RED}failed{RESET}: The file was not found.")