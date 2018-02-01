# github-authorized-keys-docker

This is a docker container which contains a perl script to pull a user's SSH keys from Github and add them to the user's ssh authorized keys file.

This will overwrite the authorized keys file, so it is only appropriate for a case where only the keys uploaded to Github should be able to log in.

Specify the github user keys to pull using an environment variable to `docker run` or `docker-compose`, like:

```
# with docker run:
docker run \
  -v ~/.ssh:/perl/.ssh \
  -e GITHUB_USER=jasongwartz \
    jasongwartz/github-authorized-keys-docker

# or with docker-compose
GITHUB_USER=jasongwartz docker-compose up -d`
```


