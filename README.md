# This docker container will run until a given port is open

[![Docker Pulls](https://img.shields.io/docker/pulls/igops/wait-for-port?logo=docker)](https://hub.docker.com/r/igops/wait-for-port)

A tiny (~3MB) netcat-driven docker image which continuously tries connecting to a specified TCP/IP endpoint, and exits when the connection is established. Running it in the foreground allows blocking the execution of some context (e.g., deploy script), unless dependent services are up.

## Usage
```shell
$ docker run --rm igops/wait-for-port HOST PORT
```

E.g.,
```shell
$ docker run --rm igops/wait-for-port 172.17.0.1 80
```
will query `172.17.0.1:80` each `0.1s`, and exit when the connection is established:
```
Waiting for 172.17.0.1:80...
OK
```

## Real-life scenarios
### Wait for a service on host OS to start accepting traffic
#### Wait for nginx:
```shell
#!/bin/sh
docker run --rm -d -p 80:80 nginx
docker run --rm --add-host="host:host-gateway" igops/wait-for-port host 80
curl -XGET 'http://localhost'
```
Output:
```
Waiting for host:80...OK
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
```

#### Wait for sshd:
```shell
#!/bin/sh
docker run --rm --add-host="host:host-gateway" igops/wait-for-port host 22
echo "SSH server is running"
```

### Waiting for another container to start accepting traffic
#### From the same docker network:
```shell
#!/bin/sh
docker network create my-bridge
docker run --rm -d --net my-bridge --net-alias my-mongo mongo
docker run --rm --net my-bridge igops/wait-for-port my-mongo 27017
echo "MongoDB is up"
```

#### Using --publish:
```shell
#!/bin/sh
docker run --rm -d -p 27017:27107 mongo
docker run --rm --add-host="docker-host:host-gateway" igops/wait-for-port docker-host 27017
echo "MongoDB is up"
```

## ENV variables
| Variable                    | Description                                              |
|-----------------------------|----------------------------------------------------------|
| CHECK_FREQUENCY             | Port scanning frequency in seconds, `0.1` is the default |
