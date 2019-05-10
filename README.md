# Setting up saltstack locally with docker

Docker Compose setup to spin up a salt master and minion.

## Requirements:

- docker (18.09.2+)
- docker-compose (1.23.2+)

(*Tested Versions)

## Setup
To start master and minion run:

`./bin/start.sh`

Console output from instances is redirected to `./docker-compose.log` file.

FYI: In case you want master and minion running in `debug` mode, modify `Dockerfiles ENTRYPOINT` to:

`ENTRYPOINT ["docker-entrypoint.sh", "debug"]`

To log in into master or minion run:

`./bin/login-{master,minion}.sh` with suffix matching specific instance.

To validate the installation run below command from master:

`salt '*' test.ping`

Result should contain two minions:

- salt-master (as his own minion)
- salt-minion (as a minion only)

## Cluster configuration

To change cluster configuration first take a look at setup of `./config` folders.

To define roles which should be installed by minions (or any other extra static information), `grains` can be used.
Keep in mind that those roles have to be correctly structured in `base, pillar, overrides`. Example of such roles are available under `base\samples`.
Roles can be used to define for example services or packages that should be installed on a minion.

All minions are by default configured to install yum repositories defined in `pillar\core\repositories` in case you need some specific ones.

## Simplifications

Master has a few aliases built in to make working with it easier:

`alias base='cd /srv/salt/base`

`alias pillar='cd /srv/salt/pillar`

`alias overrides='cd /srv/salt/pillar/overrides`

`alias saltlogs='cd /var/log/salt`

Built in editing tools: `less`, `vim`.

To apply all states on start modify master `Dockerfiles ENTRYPOINT` adding flag:

`ENTRYPOINT ["docker-entrypoint.sh", "apply-on-start"]`

## Learning

You may take a look at this [Official Tutorial](https://docs.saltstack.com/en/latest/topics/tutorials/walkthrough.html#sending-the-first-commands).


## Troubleshooting

FYI: you will see log messages like : "Could not determine init system from command line" - those are just because salt is running in the foreground and not from an auto-startup.

The salt-master is set up to accept all minions that try to connect.  Since the network that the salt-master sees is only the docker-compose network, this means that only minions within this docker-compose service network will be able to connect (and not random other minions external to docker).