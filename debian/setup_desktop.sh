#!/bin/bash

set -e

sudo test || true

start_time=$(date +%s)

for script in $(ls [0-9][0-9][0-9]_* | sort); do
    echo "Executing $script"
    #bash "$script"
done

end_time=$(date +%s)
execution_time=$((end_time - start_time))
echo "debian gnome minimal host desktop setup has been successfully completed in $execution_time seconds."
