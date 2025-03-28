#!/bin/bash

# Source and Destination directories
SOURCE_DIR="dress-up/body" # Source directory
DEST_DIR="body"   # Destination directory
SUFFIX="-light" # Suffix to append to filenames
REMOVE_SUFFIX="-body"

# Ensure the destination directory exists
mkdir -p "$DEST_DIR"

# Loop through all files in the source directory
for FILE in "$SOURCE_DIR"/*; do
  # Check if it's a file (to avoid directories or empty items)
  if [[ -f "$FILE" ]]; then
    # Get the base filename without the path
    BASENAME=$(basename "$FILE")
    
    # Remove the file extension to work with just the name
    FILENAME="${BASENAME%.*}"
    EXTENSION="${BASENAME##*.}"  # Get the file extension

    # Remove the '-body' suffix from the filename if it exists
    FILENAME="${FILENAME%$REMOVE_SUFFIX}"

    # Split the filename into parts based on the '-' delimiter
    IFS='-' read -ra PARTS <<< "$FILENAME"

    # Construct the subdirectory path dynamically
    SUBDIR="$DEST_DIR"
    for PART in "${PARTS[@]}"; do
      SUBDIR="$SUBDIR/$PART"
    done

    # Ensure the subdirectory exists
    mkdir -p "$SUBDIR"

    # Add the suffix to the filename
    NEW_FILENAME="${FILENAME}${SUFFIX}.${EXTENSION}"

    # Print the new filename (for debugging)
    echo "Copying $BASENAME to $SUBDIR/$NEW_FILENAME"

    # Copy the file into the dynamically created subdirectory with the new filename
    cp "$FILE" "$SUBDIR/$NEW_FILENAME"
  fi
done

echo "Files have been organized in $DEST_DIR."