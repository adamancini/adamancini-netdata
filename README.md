# README #

This Puppet module aims to install the netdata (http://my-netdata.io/) application and dependencies, manage the netdata.conf file, and the netdata service.

I will attempt to make this module compatible with Ubuntu 14.04 and 16.04 and possibly expand OS support later.  Pull requests are welcome.

Puppet 4 + hiera required.

### What is this repository for? ###

* Install the [netdata](https://netdata.firehol.org/) application - [project github](https://github.com/firehol/netdata)
* Ubuntu 14.04, 1604
* Puppet >= 4.3
* Hiera

### How do I get set up? ###

* Add this module to your Puppetfile like so:

```
mod 'adamancini-netdata',
  :git => 'https://bitbucket.org/adamancini/adamancini-netdata.git'
```

* Configuration
Configuration is handled via data-in-modules, new to Puppet 4.3
Defaults are in data/common.yaml
Override them locally in your own hieradata


* Dependencies
  - puppet-archive
  - puppet-stdlib
