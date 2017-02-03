# SSH Key Management

### :warning: WORK IN PROGRESS /!\ NOT READY FOR PRODUCTION :warning:

## Before starting

#### :warning: Only use this on your local network ! :warning:

This installation is in 3 parts, the `web user interface`, the `master` script and the `agent script`.

Install the jq JSON Processor program :

```bash
# apt-get install jq
```

Todo List : 
- [ ] Finalize the master and the agent
- [ ] Improve security
- [ ] Daemonize for master and agent
- [ ] Create Ansible playbook for minimal initialization
- [ ] Create simple install script
- [ ] Add possibility to list all the key in the web-ui
- [ ] Add possibility to delete the key

## The Web-UI
The web-ui allows you to put your SSH

> For the moment you can just add the SSH Key and if you want to disable it you have to fill the correct user and key you want to disable.

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

Output : 

```bash
Command : echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC/bztdcLWS8IK8tDUEaZRp+T/Vlohmni0f5FMs/1I4lCy8XSM96twyVXBo4ATYBFj61ET0CIGAzW81xDsOkWv3oKDlRzurU5TVc49KQEIjwv5DbpB6g2HznmM5oo8diDE= user@home >> /.ssh/authorized_keys
Command : echo ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAYQC4hnZYAmfr9htSIAMRc1fan6se+mLdohiTIyC+CXQ4N2JHSjqaf8Fk9MLk8Y+l4Ziapfjj8cXIMZvbC+r63f+n/3MUwu8djKnaJdi1Kek5vCCXk6zVhPg2scdhqjnH0vs= user@laptop >> /.ssh/authorized_keys
```