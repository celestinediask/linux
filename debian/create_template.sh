# create new txt file in templates

DIR=~/Templates

# Check if the directory exists
if [ ! -d "$DIR" ]; then
  # Create the directory if it doesn't exist
  mkdir -p "$DIR"
  echo "Directory created: $DIR"
else
  echo "Directory already exists: $DIR"
fi

touch ~/Templates/new.txt

echo "File ~/Templates/new.txt created successfully."
