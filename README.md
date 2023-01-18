# This docker container will run until a given port is open
A simple netcat-driven image which continuously tries connecting to some port on some host. Running it in the foreground allows blocking the execution of some context (e.g., deploy script), until dependent services are up.

## Usage
```shell
$ docker run --rm igops/wait-for-port HOST PORT
```

E.g.,
```shell
$ docker run --rm igops/wait-for-port 172.17.0.1 80
```
will query `172.17.0.1:80` each `0.1s` and exit when the connection is established:
```
Waiting for 172.17.0.1:80...
OK
```

## Real-life scenarios

**Waiting for another container to response:**
```shell
$ docker network create my-bridge
$ docker run --rm -d --net my-bridge --net-alias my-mongo mongo
$ docker run --rm --net my-bridge igops/wait-for-port my-mongo 27017
$ echo "Mongo is up at this point, do some useful stuff here"
```

**Waiting for some service on the docker host:**
```shell
$ docker run --rm --add-host="docker-host:host-gateway" igops/wait-for-port docker-host 22
$ echo "SSH server is running"
```

**Waiting for another container which published some port:**
```shell
$ docker run --rm -d -p 27017:27107 mongo
$ docker run --rm --add-host="docker-host:host-gateway" igops/wait-for-port docker-host 27017
$ echo "Mongo is up"
```

## ENV variables
| Variable                    | Description                                              |
|-----------------------------|----------------------------------------------------------|
| CHECK_FREQUENCY             | Port scanning frequency in seconds, `0.1` is the default |