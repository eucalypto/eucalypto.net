---
date: "2016-03-15T19:14:32Z"
type: "post"
image: "/posts/2013-04-14-pdf-tools/pdf-tools-for-printing.webp"
tags:
- linux
- centos
title: CentOS 7 Tips
---

## Manage additional Repositories

For CentOS 7 there exist additional repositories; for additional codecs for example. This [website](https://wiki.centos.org/AdditionalResources/Repositories) lists the most useful ones. I use the Nux-Dextop repository but I don't want to have it turned on the whole time.

So I use

    sudo yum-config-manager --enable nux-dextop

to enable this repo. And when I'm done installing or updating with
`yum`, I use

    sudo yum-config-manager --disable nux-dextop

to disable this repo again.

And with `yum repolist` you can see which repositories are currently
enabled.



## Git Server

To have a git server you just have to install `git-daemon`. Now you can
use the computer as git server with ssh.


## Lighttpd

[Lighttpd](http://www.liberiangeek.net/2014/09/install-lighttpd-webserver-centos-7-php5-mariadb-support/)
is a light web server. In CentOS its package is in the
[EPEL](https://wiki.centos.org/de/AdditionalResources/Repositories/)
repository. After installing this package you can run it with bash:

{{< highlight bash >}}
sudo systemctl start lighttpd.service
{{< / highlight >}}

CentOS ships with a firewall. We have to
[configure](http://dokuwiki.nausch.org/doku.php/centos:web_c7:apache_1) it
so that our server is accessible from outside:

{{< highlight bash >}}
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
{{< / highlight >}}

During the installation of Lighttpd, a new user is created: "lighttpd".
This is the same as "www-data" for apache. To find out where the
document root of the server is supposed to be, have a look at
`/etc/passwd`. There you will find the "home" directory of "lighttpd":
`/var/www/lighttpd`.

Now open `/etc/lighttpd/lighttpd.conf` and check if the document
directory is in the right place:

    var.server_root = "/var/www"
    [...]
    server.document-root = server_root + "/lighttpd"



## Baikal

Baikal is a php based CalDav and CardDav server. It uses SQLite as
database. So you need to make sure the following programs are installed:

* SQLite
* PHP (>5.3)
* Some webserver (e.g. apache `httpd.x86_64` or `lighttpd`)
