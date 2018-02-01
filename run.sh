docker run \
  -v ~/.ssh:/perl/.ssh \
  -e GITHUB_USER=$(whoami) \
  -e SLEEP_TIME=900 \
  --name ssh-keys --restart=always \
    jasongwartz/github-authorized-keys-docker
