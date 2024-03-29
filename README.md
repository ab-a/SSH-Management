[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![made-with-bash](https://img.shields.io/badge/Made%20with-Bash-1f425f.svg)](https://www.gnu.org/software/bash/)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](http://makeapullrequest.com)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-no-red.svg)]()
[![Prod](https://img.shields.io/badge/Prod%3F-Unsecure-red.svg)]()

# SSH Key Management
With this program you'll be able to add your ssh key through a web-ui.

The keys will be store in a json file.

A small script installed on all hosts will pull the json file and add keys for concerned users.

Note : the json database is only store on the web-ui server.
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
- __`[1]`__ - adding the ssh keys to the json database through the web-ui
- __`[2]`__ - agent ask the master to get the json
- __`[3]`__ - master send the json and the agent apply all modification itself

#### :warning: not for production, use at your own risk :warning:

### Todo List : 
- [x] Configuration file for the master
- [x] Simple and fonctionnal web-ui
- [x] Manage key through json
- [x] Possibility to disable key
- [x] Improve security and clean code
- [x] Add possibility to list all the key in the web-ui
- [x] Add possibility to delete the key directly on the web-ui

## Prerequisites
```bash
# apt-get install jq git php5-fpm nginx
```
## Installation
#### Master
Create an user who can manage the SSH-Key and specify the home (here `/srv/ssh-management`) and clone the repo : 
```bash
# useradd -m -d /srv/ssh-management ssh-management
# cd ~
# git clone https://github.com/ab-a/sshkey.git 
# cp -r sshkey/master/web-ui /srv/ssh-management
```
#### Agent
The agent will be run with the user root (or any user with root to have the right to edit all `.ssh/auhorized_keys`.).
Generate an SSH Key and push it to the master server : 
```bash
# ssh-keygen -t rsa -b 4096
```
The agent will ask the master, pull and parse the json and set the keys.
## The Web-UI
The web-ui allows you to push your SSH key into the json. 

--------------------------------
![simple web-ui](http://i.imgur.com/2Twj9WN.png)

--------------------------------

Source : [https://www.sanwebe.com/2014/08/css-html-forms-designs](https://www.sanwebe.com/2014/08/css-html-forms-designs)
