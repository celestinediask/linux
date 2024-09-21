set -e
# debian go dev env setup

sudo test || true

PROJECT_ROOT="../.."

# Check if the system is Debian-based
if ! grep -q "^ID=debian" /etc/os-release; then
	echo "$THIS_SCRIPT is intended for Debian-based distributions only. Exiting."
	exit 1
fi

# Check for internet connectivity
if ! ping -c 1 9.9.9.9 > /dev/null 2>&1; then
    echo "No internet connection. Exiting..."
    exit 1
fi

# install postgres
if command -v psql > /dev/null 2>&1; then
  echo "PostgreSQL is already installed. Skipping installation."
else
  echo "PostgreSQL is not installed. Installing now..."
  
  # Update package list
  sudo apt update
  
  # Install PostgreSQL
  sudo apt install -y postgresql #postgresql-contrib

  echo "PostgreSQL installation complete."
fi

# install vscode
$PROJECT_ROOT/debian/repo/add_repo_vscode.sh

# install go
$PROJECT_ROOT/install_go.sh

# postman
$PROJECT_ROOT/install_postman.sh

# install docker

echo "Successfully completed GO Dev Env."
