# setup firefox profile

PROJECT_ROOT=$(realpath ..)
TEMP_DIR=$PROJECT_ROOT/tmp

if [ ! -d "$TEMP_DIR" ]; then
    mkdir -p "$TEMP_DIR"
    echo "Directory '$TEMP_DIR' has been created."
fi

cd $TEMP_DIR
git clone https://github.com/etosy/firefox
cd firefox
./remove_bloat.sh
