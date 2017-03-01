# README #

This Puppet module aims to install the netdata (http://my-netdata.io/) application and dependencies, manage the netdata.conf file, and the netdata service.

I will attempt to make this module compatible with Ubuntu 14.04 and 16.04 and possibly expand OS support later.  Pull requests are welcome.

Puppet 4+, hiera required.
PuppetDB highly recommended.

### What is this repository for? ###

* Install the [netdata](https://netdata.firehol.org/) application - [project github](https://github.com/firehol/netdata)
* Ubuntu 14.04, 16.04
* Puppet >= 4.3
* Hiera
* PuppetDB for charts support

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

### License ###
This module is Copyright 2016, Ada Mancini

[netdata](https://github.com/firehol/netdata) is released under the GPLv3

This module is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
