#!/bin/bash

# Define the music folder and log file path
MUSIC_FOLDER="/mnt/Data/Japanese Audiobooks/"
LOG_FILE="/tmp/navidrome_logfile.log"

# Create the log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Check if Navidrome is already running
if pgrep -x "navidrome" > /dev/null; then
    echo "Navidrome is already running. Exiting."
else
    # Run Navidrome command, redirecting output to the log file and detaching it from the terminal
    setsid nohup navidrome --musicfolder "$MUSIC_FOLDER" > "$LOG_FILE" 2>&1 &
    echo "Navidrome started and detached from the terminal."
fi
