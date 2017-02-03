# SSH Key Management

[alert warning]### WARNING : WORK IN PROGRESS /!\ NOT READY FOR PRODUCTION[/alert]

## Before starting

[alert warning]#### Only use this on your local network ![/alert]

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
> The web-ui allows you to put your SSH
> For the moment you can just add the SSH Key and if you want to disable it you have to fill the correct user and key you want to disable.

Source : [https://www.sanwebe.com/2014/08/css-html-forms-designs](https://www.sanwebe.com/2014/08/css-html-forms-designs)

## The master
> The master is here to push the json on all servers you've specified in hosts.conf.

### The hosts.conf

> The lines with `[Hostgroup Example]` are comments.
> The line have to be formated exactly like that :

```bash
[Comment]
ip:username
```

> or

```bash
[Comment]
hostname:username
```
> Example : 

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


=======
# SSH-Key-Management
Manage your SSH Key efficiently
