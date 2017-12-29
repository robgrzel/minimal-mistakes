---
layout: splash
permalink: /notes/bash_notes/
title: "Bash Notes"
excerpt: "Bash specific commands that may be useful if at hand."
toc: true
author_profile: false
---

# SPECIFIC COMMANDS 

---

## PRINTING AND WRITING TO FILE

```bash
# print to file with new lines:
printf '%s\n    %s\n' 'Host localhost' 'ForwardAgent yes' >> file.txt

# append at end of file
echo "end" >> myfile.txt
```
---

## PERMISSIONS AND USERS
```bash
# change permissions of files in dir
sudo chmod -r 777 /dir

# change ownership of files in dir
sudo chown -r nobody:nogroup /dir

# check users
cat /etc/passwd

# create new user with password 1 and in sudoers group
useradd -m -d /home/pintos -s /bin/bash pintos
echo -e '1\n1' | passwd pintos --stdin
#if centos
usermod -aG wheel pintos 
#if ubuntu :
sudo adduser pintos sudo
```
---