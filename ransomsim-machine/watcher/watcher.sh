#!/bin/bash
set -u

WATCH_DIR=/data/shared
ACTIVITY_THRESHOLD=30
RENAME_THRESHOLD=30
WINDOW_SECONDS=10

activity_count=0
rename_count=0
window_start=$(date +%s)

inotifywait -m -r -e moved_to,close_write,delete --format '%w%f|%e' "$WATCH_DIR" |
while IFS='|' read -r file event; do
    now=$(date +%s)
    if (( now - window_start > WINDOW_SECONDS )); then
        activity_count=0
        rename_count=0
        window_start=$now
    fi

    activity_count=$((activity_count + 1))

    if [[ "$event" == *MOVED_TO* && "$file" == *.locked ]]; then
        rename_count=$((rename_count + 1))
        if (( rename_count == RENAME_THRESHOLD )); then
            echo "mayajal_monitor event=mass_rename outcome=threshold_reached path=$WATCH_DIR extension_added=.locked count=$rename_count"
        fi
    fi

    if [[ "$file" == *"/.canary_772x"* ]]; then
        echo "mayajal_monitor event=canary_modified outcome=detected path=$file"
    fi

    filename=${file##*/}
    if [[ "$filename" == README* || "$filename" == *DECRYPT* ]]; then
        echo "mayajal_monitor event=ransom_note_created outcome=detected path=$file"
    fi

    if (( activity_count == ACTIVITY_THRESHOLD )); then
        echo "mayajal_monitor event=file_activity_burst outcome=threshold_reached path=$WATCH_DIR count=$activity_count window_seconds=$WINDOW_SECONDS"
    fi
done &
watcher_pid=$!

cleanup() {
    kill "$watcher_pid" 2>/dev/null || true
    wait "$watcher_pid" 2>/dev/null || true
}

trap cleanup EXIT
trap 'exit 0' TERM INT

while kill -0 "$watcher_pid" 2>/dev/null; do
    echo "mayajal_monitor event=heartbeat outcome=alive"
    sleep 15
done

exit 1
