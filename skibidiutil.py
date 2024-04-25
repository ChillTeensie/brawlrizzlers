# gpt code 🤑🤑🤑🤑

import os
import shutil

def copy_files(source_dir, destination_dir):
    # Ensure both source and destination directories exist
    if not os.path.exists(source_dir):
        print(f"Source directory '{source_dir}' does not exist.")
        return
    if not os.path.exists(destination_dir):
        print(f"Destination directory '{destination_dir}' does not exist.")
        return

    # Walk through the source directory
    for root, dirs, files in os.walk(source_dir):
        for file in files:
            source_file = os.path.join(root, file)
            destination_file = os.path.join(destination_dir, os.path.relpath(source_file, source_dir))

            # Check if the file already exists in the destination
            if os.path.exists(destination_file):
                # Compare modification times
                source_mtime = os.path.getmtime(source_file)
                dest_mtime = os.path.getmtime(destination_file)

                # If source file is older, skip copying
                if source_mtime < dest_mtime:
                    print(f"Skipping '{source_file}' as the existing file is newer.")
                    continue

            # Copy the file to the destination
            try:
                shutil.copy2(source_file, destination_file)
                print(f"Copied '{source_file}' to '{destination_file}'.")
            except Exception as e:
                print(f"Error copying '{source_file}' to '{destination_file}': {e}")

# Source and destination directories
source_directory = "assets/export/debug/windows/bin/assets/scripts"
destination_directory = "assets/scripts"

# Copy files from source to destination
copy_files(source_directory, destination_directory)

