#!/bin/bash

logfile="website_status.log"

> "$logfile"

while IFS= read -r site; do
  status_code=$(curl -o /dev/null -s -w "%{http_code}\\n" $site)
  if [ "$status_code" -eq 200 ]; then
    echo "$site is UP ($status_code)" | tee -a "$logfile"
  else
    echo "$site is DOWN ($status_code)" | tee -a "$logfile"
  fi
done < "sites.txt"

echo "The results were written to the log file: $logfile"
