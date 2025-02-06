# setup firefox profile

TEMP_DIR="temp"
CUR_DIR=$(pwd)

# Check if Git is installed
if ! command -v git &> /dev/null; then
  echo "git is not installed. Skipping..."
  exit 0
fi

if [ ! -d "$TEMP_DIR" ]; then
    mkdir -p "$TEMP_DIR"
    echo "Directory '$TEMP_DIR' has been created."
fi

cd $TEMP_DIR
git clone https://github.com/etosy/firefox
cd firefox
./remove_bloat.sh

cd "$CUR_DIR"
