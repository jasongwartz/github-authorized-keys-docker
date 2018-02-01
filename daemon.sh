set -x
set -e

while true; do
    perl github-ssh-keys.pl
    sleep $SLEEP_TIME
done