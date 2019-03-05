# Setting up saltstack locally with docker

Docker Compose setup to spin up a salt master and minions.

## Requirements:

- docker (18.09.2+)
- docker-compose (1.23.2+)

(*Tested Versions)

## Setup
To start master and two minions run:

`./bin/start.sh`

Console output from instances is redirected to `./docker-compose.log` file.

FYI: master and minions will be running in `debug` mode, to change that, modify `Dockerfiles`.

To log into master or minions run:

`./bin/login-{master,minion1,minion2}.sh` with suffix matching specific instance.

To validate the installation run below command from master:

`salt '*' test.ping`

Result should contain two minions.

## How to proceed

You may take a look at this [Official Tutorial](https://docs.saltstack.com/en/latest/topics/tutorials/walkthrough.html#sending-the-first-commands).


## Troubleshooting

FYI: you will see log messages like : "Could not determine init system from command line" - those are just because salt is running in the foreground and not from an auto-startup.

The salt-master is set up to accept all minions that try to connect.  Since the network that the salt-master sees is only the docker-compose network, this means that only minions within this docker-compose service network will be able to connect (and not random other minions external to docker).
