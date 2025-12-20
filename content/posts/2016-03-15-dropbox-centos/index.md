---
author: eucalypto
date: "2016-03-15T19:14:32Z"
type: "post"
image: "/posts/2013-04-14-pdf-tools/pdf-tools-for-printing.webp"
tags:
- linux
- centos
- dropbox
title: Dropbox in CentOs 7
---

## Install Dropbox in CentOS 7

This [website] has a nice overview over the installation process. First, you need to

{{< highlight bash >}}
sudo yum install libgnome
{{< / highlight >}}

and then download the Dropbox Fedora (.rpm) package from [Dropbox] and install it with

{{< highlight bash >}}
sudo rpm -ivh nautilus-dropbox[...].rpm
{{< / highlight >}}


Then you can start Dropbox and log in with your accound details.

## Repair package manager yum

If you use yum (e.g `yum update`) after Dropbox installation, you will
probably encounter an error that a certain .xml file could not be found.
This [blog entry] describes the problem:

The Package is made for Fedora and Fedora has a different release cycle
than CentOS. But the package repository configuration of Dropbox
`/etc/yum.repos.d/dropbox.repo` uses the variable `$releasever`, which
is different for Fedora and CentOS.

To solve this problem you have to replace the line

    baseurl=http://linux.dropbox.com/fedora/$releasever/

with

    baseurl=http://linux.dropbox.com/fedora/21/

The number `21` is just the newest Fedora version supported by Dropbox.
Yo can look for the current supported versions on [their website].

## Run Dropbox as a service

In order to have Dropbox available right after boot without loggin in,
it has to be declared a service.

[TODO] Find out how?


[website]: http://computechtips.com/790/install-dropbox-centos-7
[Dropbox]: https://www.dropbox.com/install?os=lnx 
[blog entry]: http://software-engineer.gatsbylee.com/dropbox-yum-update-error-on-centos/
[their website]: https://linux.dropbox.com/fedora/
