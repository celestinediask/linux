set -e
# debian go dev env setup

THIS_SCRIPT=$(basename "$0")
#echo "running: $THIS_SCRIPT"

PROJECT_ROOT=$(realpath ..)

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

sudo test || true

# install postgresql
if command -v psql > /dev/null 2>&1; then
  echo "postgresql is already installed. Skipping..."
else
  echo "postgresql is not installed. Installing now..."
  
  sudo apt update
  
  sudo apt install -y postgresql #postgresql-contrib

  echo "PostgreSQL installation complete."
fi

# install go
$PROJECT_ROOT/install_go.sh

# install vscode and go extension
$PROJECT_ROOT/debian/repo/install_code.sh
code --list-extensions | grep -q golang.go || code --install-extension golang.go

# postman
$PROJECT_ROOT/install_postman.sh

# install docker

echo "Successfully completed GO Dev Env."
