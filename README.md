# SaltStack Cheat Sheet

This Cheat Sheet started as notes for book [“Learning SaltStack”](https://www.packtpub.com/networking-and-servers/learning-saltstack-second-edition).
Also this notes is suplemented from the following Cheat Sheets:
* [GitHub - harkx/saltstack-cheatsheet: SaltStack Cheat Sheet](https://github.com/harkx/saltstack-cheatsheet)
* [GitHub - eon01/SaltStackCheatSheet: SaltStack Cheat Sheet](https://github.com/eon01/SaltStackCheatSheet)

## Quickstart
```sh
salt '*' test.ping

salt '*' user.add larry
salt '*' user.info larry

salt '*' pkg.install nginx
salt '*' pkg.list_pkgs

salt '*' service.status nginx
```

## Documentation
```sh
salt 'salt-minion-1' sys.list_functions test # List functions
salt '*' sys.list_state_functions pkg  # Functions that can be used in states
salt '*' sys.list_modules
salt '*' sys.state_doc pkg.removed
salt '*' sys.doc test.fib # Show documentation
salt '*' sys.doc test
```

## General
```sh
# Here is the full version information 
salt --versions-report

# Format output
salt --out=json '*' cmd.run_all 'echo OK'
--out=nested|yaml|json|quiet|....
```

## Master configuration
```sh
# Key management

# minion
salt-call --local key.finger
# master
salt-key  # keys info
salt-key -f salt-minion-1  # show fingerprint
salt-key -a salt-minion-1  # accept key
```

## Minion management
```sh
# Minion info
salt '*' status.discusage
salt '*' status.loadavg
salt '*' status.meminfo
salt '*' status.uptime

# Syncing
salt '*' saltutil.sync_all
salt '*' saltutil.sync_grains
salt '*' saltutil.sync_modules
salt '*' saltutil.sync_pillars
salt '*' saltutil.refresh_pillar

# Jobs
salt-run jobs.active      # get list of active jobs
salt-run jobs.list_jobs   # get list of historic jobs
salt-run jobs.lookup_jid <job id number>  # get details of this specific job

# Minons connected to master
salt-run manage.up
salt-run manage.status
salt-run manage.down
```

## States
```sh
salt '*' state.sls xxx.yyy
salt '*' state.highstate
salt '*' state.show_sls search_str *  # Search string in states

# Rendering
salt '*' slsutil.renderer /path/to/file.sls 'jinja|yaml'
```

## Matching
```sh
# Globbing
salt '*' test.ping
salt 'salt-minion-*' test.ping
salt 'salt-minion-?' test.ping
salt -E 'salt-.*-\d' test.ping
salt -L 'salt-minion-1,salt-minion-2' test.ping

# Compund matching
salt -C '* and not G@os_family:RedHat' test.ping

# Grains-based host matching
salt --grain 'os_family:Debian' test.ping
*salt -G 'os:Ubuntu' test.ping*
*salt -G 'os:u*' test.ping*
```

## Grains & Pillars management
```sh
# Grains represent static data describing a minion

# Getting information
salt '*' grains.item os_family
salt '*' grains.item os
salt '*' grains.item osfinger
salt '*' grains.items

# Editing/updating grains
salt '*' grains.setval foo bar
salt '*' grains.item foo
salt '*' grains.setval baz '["larry", "moe", "curly"]'
salt '*' grains.delval baz
salt '*' grains.delval baz destructive=True
```

## Useful modules
```sh
# Run command
salt '*' cmd.run 'echo Hello!'
salt '*' cmd.run_stdout 'echo Hello!'
salt '*' cmd.run_stderr 'echo Hello!'
salt '*' cmd.retcode 'echo Hello!'
salt '*' cmd.run_all 'echo Hello!'

# Packages
salt '*' pkg.list_upgrades
salt '*' pkg.upgrade
salt '*' pkg.version bash
salt '*' pkg.install bash
salt '*' pkg.install bash refresh=True 

# Services
salt '*' service.status <service name>
salt '*' service.available <service name>
salt '*' service.start <service name>
salt '*' service.restart <service name>
salt '*' service.stop <service name>

# Network
salt 'minion1' network.ip_addrs
salt 'minion1' network.ping <hostname>
salt 'minion1' network.traceroute <hostname>
salt 'minion1' network.get_hostname
salt 'minion1' network.mod_hostname

# http
salt-run http.query http://eon01.com text=true
salt-run http.query http://eon01.com headers=true
salt-run http.query http://eon01.com status=true
salt '*' http.query http://domain.com/ method=POST params='key1=val1&key2=val2'
```

## Reactor
```sh
salt-call event.send foo '{foo: bar}' 
```

## Salt Cloud
```sh
# Manage configs
salt-cloud --list-providers
salt-cloud --list-images digitalocean-config
salt-cloud --list-sizes digitalocean-config
salt-cloud --list-locations digitalocean-config

salt-cloud -p ubuntu minion1 minion2  # Create two minions
salt-cloud -d minion1 minion2  # Delete minions
salt-cloud -m ./cluster.map -d -P  # Deploy cluster.map parallel

salt-cloud --query  # Show cluster
salt-cloud -a reboot minion1  # Cloud actions
```

## Links
* [Embedded salt modules: salt/salt/modules](https://github.com/saltstack/salt/tree/develop/salt/modules)
* [Configuring the Salt Minion](https://docs.saltstack.com/en/latest/ref/configuration/minion.html)
* [Configuring the Salt Master](https://docs.saltstack.com/en/latest/ref/configuration/master.html)
* [Configuring the Salt Cloud](https://docs.saltstack.com/en/latest/topics/cloud/config.html)
* [Configuration file examples](https://salt.readthedocs.io/en/stable/ref/configuration/examples.html)
* [State System Reference](https://docs.saltstack.com/en/latest/ref/states/)
