<a href="#"><img src="foreman.png" title="Foreman" alt="Foreman"></a>


<!-- [![FVCproductions](https://avatars1.githubusercontent.com/u/4284691?v=3&s=200)](http://fvcproductions.com) -->

# Foreman Open Source Project

> Foreman is an open source project that helps system administrators manage servers throughout their lifecycle, from provisioning and configuration to orchestration and monitoring. Using Puppet, Chef, Salt, Ansible and Foreman’s smart proxy architecture, you can easily automate repetitive tasks, quickly deploy applications, and proactively manage change, both on-premise with VMs and bare-metal or in the cloud.




[![Build Status](http://img.shields.io/travis/badges/badgerbadgerbadger.svg?style=flat-square)](https://travis-ci.org/badges/badgerbadgerbadger) [![Coverage Status](http://img.shields.io/coveralls/badges/badgerbadgerbadger.svg?style=flat-square)](https://coveralls.io/r/badges/badgerbadgerbadger) [![Badges](http://img.shields.io/:badges-9/9-ff6799.svg?style=flat-square)](https://github.com/badges/badgerbadgerbadger)


- For more on these wonderful ~~badgers~~ badges, refer to <a href="http://badges.github.io/badgerbadgerbadger/" target="_blank">`badgerbadgerbadger`</a>.



---

## Table of Contents (Optional)


- [Installation](#installation)
- [Features](#features)
- [Contributing](#contributing)
- [Team](#team)
- [FAQ](#faq)
- [Support](#support)


---



## Installation

- Supported platforms

>    CentOS, Scientific Linux or Oracle Linux 7, x86_64
>    Debian 9 (Stretch), i386/amd64/armhf/aarch64
>    Red Hat Enterprise Linux 7, x86_64
>    Ubuntu 16.04 (Xenial), i386/amd64/armhf/aarch64

- Considering Centos 7 For Installation Of Foreman on localhost machine

- Using a recent version of Puppet is recommended, which is available from the Puppet Labs repository. To use Puppet 5.x with Puppet Agent and Puppet Server: 


```shell
 $ sudo yum -y install https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
```

- Enable the EPEL (Extra Packages for Enterprise Linux) and the Foreman repos:


```shell
$ sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
```


```shell
$ sudo yum -y install https://yum.theforeman.org/releases/1.17/el7/x86_64/foreman-release.rpm
```

- Downloading the installer

```shell
$ sudo yum -y install foreman-installer
```

- Running the installer
  
```shell
 $  sudo foreman-installer
```

- After it completes, the installer will print some details about where to find Foreman and the Smart Proxy and Puppet master if they were installed along Foreman. Output should be similar to this:

   * Foreman is running at https://theforeman.example.com
      Initial credentials are admin / 3ekw5xtyXCoXxS29
  * Foreman Proxy is running at https://theforeman.example.com:8443
  * Puppetmaster is running at port 8140
  The full log is at /var/log/foreman-installer/foreman-installer.log



  
	


### Clone

- Clone this repo to your local machine using `https://github.com/VARADSP/Foreman_Code`

### Setup Foreman On Virtual Machine Using Vagrant


> Installing Vagrant First from https://www.vagrantup.com/downloads.html
> Download and install vagrant from the url
> Just run vagrant up which will configure VM from Vagrantfile
> This will setup a virtual machine with foreman installed

```shell
$ vagrant up
```


- For all the possible languages that support syntax highlithing on GitHub (which is basically all of them), refer <a href="https://github.com/github/linguist/blob/master/lib/linguist/languages.yml" target="_blank">here</a>.

---

## Features

-    Discover, provision and upgrade your entire bare-metal infrastructure
-    Create and manage instances across private and public clouds
-    Group your hosts and manage them in bulk, regardless of location
-    Review historical changes for auditing or troubleshooting
-    Extend as needed via a robust plugin architecture
-    Automatically build images (on each platform) per system definition to optimize deployment

## Usage

Foreman provides comprehensive, interaction facilities including a web frontend, CLI and RESTful API which enables you to build higher level business logic on top of a solid foundation.


## Documentation

Refer to foreman documentation to know more
`https://www.theforeman.org/documentation.html`

## Tests

- Used Centos 7 to install and configure foreman on bare metal
- I utilized this nifty <a href="https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet" target="_blank">Markdown Cheatsheet</a> for this sample `README`.

---

## Contributing

> To get started...
> Fork the repo
> start contributing by writing ansible playbooks for populating entities in foreman such adding user,architecture,hosts using hammer cli and ansible plugin

### Step 1

- **Option 1**
    - 🍴 Fork this repo!

- **Option 2**
    - 👯 Clone this repo to your local machine using `https://github.com/VARADSP/Foreman_Code`

### Step 2

- Install and configure foreman ---- **HACK AWAY!** 🔨🔨🔨

### Step 3

- 🔃 Create a new pull request using <a href="https://github.com/VARADSP/SForeman_Code/compare/" target="_blank">`https://github.com/VARADSP/Foreman_Code/compare/`</a>.

---

## Team

>  Contributors/People

| <a href="https://github.com/VARADSP" target="_blank">**Varad Parlikar**</a> |<a href="https://github.com/VARADSP" target="_blank">`https://github.com/VARADSP`</a>|  [![VSPContributions](vsp.jpg)](https://github.com/VARADSP)    
|  


---

## FAQ

- **How do I do *specifically* so and so?**
    - No problem! Just do this.

---

## Support

Reach out to me at one of the following places!

- Blog Website at <a href="http://debuggingbug.wordpress.com" target="_blank">`debuggingbug.wordpress.com`</a>
- Twitter at <a href="http://twitter.com/varadsp" target="_blank">`@varadsp`</a>
- Facebook at Varad Parlikar

---


