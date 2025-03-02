import socket
import os

GREEN = '\033[92m'
RED = '\033[91m'
RESET = '\033[0m'

sources_list_file = '/etc/apt/sources.list.bak'

def file_exists(file_path):
    return os.path.isfile(file_path)

# test backup file sources_list_file
if file_exists(sources_list_file):
    print(f"Test {GREEN}passed{RESET}: backup file: {sources_list_file}.")
else:
    print(f"Test {RED}failed{RESET}: backup file: {sources_list_file}.")