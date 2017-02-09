# SSH Key Management

### :warning: Only use this on your local network ! :warning:

With this program you'll be able to add your ssh key through a web-ui. 

> The keys will be store in a json file.
> A small agent deamon installed on all host will pull the json file and add keys for concerned users.
> Work in progress : the json file will be send through ssh pipe to the distant servers so it will never be on other servers.

### Todo List : 
- [x] Configuration file for the master
- [x] Simple and fonctionnal web-ui
- [x] Manage key through json
- [x] Possibility to disable key
- [ ] Pass the json through ssh pipe
- [ ] Correct some behaviour in the agent (multi-add problem)
- [ ] Daemonize the master and the agent [:sunny:]
- [ ] Improve security
- [ ] Create Ansible playbook for minimal initialization
- [ ] Create simple install script
- [ ] Add possibility to list all the key in the web-ui
- [ ] Add possibility to delete the key
- [ ] Clean code

## Before starting

#### :warning: WORK IN PROGRESS - NOT YET READY FOR PRODUCTION :warning:

Install the jq JSON Processor program :

```bash
# apt-get install jq
```

## Installation

This installation is in 3 parts, the `web user interface`, the `master` script and the `agent` script.

### Master

Create an user who manage the SSH-Key and specify the home (here `/srv/ssh-management`) : 

```bash
# useradd -m -d /srv/ssh-management ssh-management
```

### Agent

The agent will be run with the user root (or any user with root rights).

Generate an SSH Key to connect to the master with the user root : 

```bash
# ssh-keygen -t rsa -b 4096
```

## The json

The json databse is the file where are stored all key and user. 

There is 3 values in the `keys` array : 

- __`"username"`__ - the username associated with the key
- __`"key"`__ - the ssh-key itself
- __`"enabled"`__ - boolean cast to int, if true (1) the key will be added

Sample : 

```json
{
  "keys": [
    {
      "username": "user",
      "key": "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC/bztdcLWS8IK8tDUEaZRp+T/Vlohmni0f5FMs/1I4lCy8XSM96twyVXBo4ATYBFj61ET0CIGAzW81xDsOkWv3oKDlRzurU5TVc49KQEIjwv5DbpB6g2HznmM5oo8diDE= user@home",
      "enabled": 1
    }
  ]
}
```

## The Web-UI
The web-ui allows you to push your SSH key into the json. 

> For the moment you can just add the SSH Key and if you want to disable it you have to fill the correct user and key you want to disable.

![simple web-ui](http://image.prntscr.com/image/534723fa7a7642cc842ee6b3f37b8ab1.png)

Source : [https://www.sanwebe.com/2014/08/css-html-forms-designs](https://www.sanwebe.com/2014/08/css-html-forms-designs)

## The master

The master is here to push the json on all servers you've specified in hosts.conf.

Every agent can ask the master if the agent have the right to connect to the master (properly set the ssh key).

### The hosts.conf

The line have to be formated exactly like that :

```bash
[Comment]
ip:username
```

or

```bash
[Comment]
hostname:username
```
Example : 

```bash
[Web-Servers]
10.2.3.4:username
web2.local.host:username

[SQL Servers]
10.2.3.8:username
sql2.local.host:username

[Backups]
backup-server1.local.host:username
backup-server2.local.host:username
```

> The lines with `[Hostgroup Example]` are comments.

## The agent

The agent will ask the master, pull and parse the json and set the keys.

> It must be run by any other user who have the right to edit all `.ssh/auhorized_keys`.

### Testing : 

```bash
$ chmod +x agent/agent.sh
$ ./agent.sh
```

## Examples

### Agent 

With the agent and the db.json example file, with 2 keys enabled and 1 keys disabled : 

Result like this (check the `db.json` file) : 

```bash
Command : echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC/bztdcLWS8IK8tDUEaZRp+T/Vlohmni0f5FMs/1I4lCy8XSM96twyVXBo4ATYBFj61ET0CIGAzW81xDsOkWv3oKDlRzurU5TVc49KQEIjwv5DbpB6g2HznmM5oo8diDE= user@home" >> /.ssh/authorized_keys
Command : echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC4hnZYAmfr9htSIAMRc1fan6se+mLdohiTIyC+CXQ4N2JHSjqaf8Fk9MLk8Y+l4Ziapfjj8cXIMZvbC+r63f+n/3MUwu8djKnaJdi1Kek5vCCXk6zVhPg2scdhqjnH0vs= user@laptop" >> /.ssh/authorized_keys
```

## Global Summary

```bash
    +-------+
    | WEBui |
    +---+---+
        |  [1]           
+-------|--------+                +-----------------+
|       v        |        [2]     |                 |
|     MASTER     |  <----------------    AGENT      |
|       |        |                |        ^        |
+-------|--------+                +--------|--------+
        |                                  |
        +----------------------------------+
                         [3]
```

- __`[1]`__ - adding of the ssh keys through the web-ui
- __`[2]`__ - agent ask the master to get the json
- __`[3]`__ - master send the json and the agent apply all modificationssh-key itself