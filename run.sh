docker run \
  -v ~/.ssh:/root/.ssh \
  -e GITHUB_USER=$(whoami) \
  --name ssh-keys --restart=always \
    jasongwartz/github-authorized-keys-docker:arm
