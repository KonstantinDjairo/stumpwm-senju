#!/bin/bash

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

LOG_FILE="/tmp/goldendict_logfile.log"


# Create the log directory if it doesn't exist
mkdir -p "$(dirname "$LOG_FILE")"

# Check if goldendict is already running
if pgrep -x "goldendict" > /dev/null; then
    echo "GoldenDict is already running. Exiting."
else
    # Run Goldendict command, redirecting output to the log file and detaching it from the terminal
    setsid nohup goldendict  > "$LOG_FILE" 2>&1 &
    echo "GoldenDict started and detached from the terminal."
fi


