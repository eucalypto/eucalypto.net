---
author: eucalypto
date: "2016-10-10T20:19:32Z"
description: Collection of useful SSH tips; remote command line.
type: "post"
image: "/posts/2013-04-14-pdf-tools/pdf-tools-for-printing.webp"
tags:
- linux
- ssh
- command-line
title: SSH Tips
---

## Run ssh-agent in remote login

When you log into a machine with SSH and want to use a SSH key to do further
stuff, like managing a remote git repository, you may have to

{{< highlight bash >}}
eval $(ssh-agent -s)
ssh-add ~/.ssh/your_ssh_id
{{< / highlight >}}

according to
[this site]. Then the shell remembers your SSH key as long as it is open.

[this site]: http://serverfault.com/questions/672346/straight-forward-way-to-run-ssh-agent-and-ssh-add-on-login-via-ssh
