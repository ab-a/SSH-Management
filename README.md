# SSH Key Management

### :warning: Only use this on your local network ! :warning:

With this program you'll be able to add your ssh key through a web-ui. 

The keys will be store in a json file and push to all server with a master daemon.

There is a small agent deamon will read the json file and push keys for all users.

## Before starting

#### :warning: WORK IN PROGRESS - NOT YET READY FOR PRODUCTION :warning:

This installation is in 3 parts, the `web user interface`, the `master` script and the `agent` script.

Install the jq JSON Processor program :

```bash
# apt-get install jq
```
### Agent User 

* Create an user on all the host you want to push the ssh keys
* Add his ssh key to authorized keys in order to push the json

For security you can chroot this user and restrict the right on the json database.

In future I'll create an Ansible Playbook to do that easily.

### Todo List : 
- [x] Configuration file for the master
- [x] Simple and fonctionnal web-ui
- [ ] Correct some behaviour in the agent (multi-add problem)
- [ ] Finalize and daemonize the master and the agent
- [ ] Improve security
- [ ] Create Ansible playbook for minimal initialization
- [ ] Create simple install script
- [ ] Add possibility to list all the key in the web-ui
- [ ] Add possibility to delete the key
- [ ] Clean code

## The Web-UI
The web-ui allows you to push your SSH key into the json. 

> For the moment you can just add the SSH Key and if you want to disable it you have to fill the correct user and key you want to disable.

![simple web-ui](http://image.prntscr.com/image/534723fa7a7642cc842ee6b3f37b8ab1.png)

Source : [https://www.sanwebe.com/2014/08/css-html-forms-designs](https://www.sanwebe.com/2014/08/css-html-forms-designs)

## The master

The master is here to push the json on all servers you've specified in hosts.conf. 

### The hosts.conf

> The lines with `[Hostgroup Example]` are comments.

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

## The agent

> The agent read the json and push all enabled keys.

## Examples

### Agent 

With the agent and the db.json example file, with 2 keys enabled and 1 keys disabled : 

```bash
$ chmod +x agent/agent.sh
$ ./agent.sh
```

Result : 

```bash
Command : echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC/bztdcLWS8IK8tDUEaZRp+T/Vlohmni0f5FMs/1I4lCy8XSM96twyVXBo4ATYBFj61ET0CIGAzW81xDsOkWv3oKDlRzurU5TVc49KQEIjwv5DbpB6g2HznmM5oo8diDE= user@home" >> /.ssh/authorized_keys
Command : echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC4hnZYAmfr9htSIAMRc1fan6se+mLdohiTIyC+CXQ4N2JHSjqaf8Fk9MLk8Y+l4Ziapfjj8cXIMZvbC+r63f+n/3MUwu8djKnaJdi1Kek5vCCXk6zVhPg2scdhqjnH0vs= user@laptop" >> /.ssh/authorized_keys
```