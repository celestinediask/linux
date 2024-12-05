# create new txt file in templates
if [ -d ~/Templates ]; then
    # Create the new file
    touch ~/Templates/new.txt
    echo "File ~/Templates/new.txt created successfully."
else
    echo "Directory ~/Templates does not exist. Could not able to create new.txt template"
fi
