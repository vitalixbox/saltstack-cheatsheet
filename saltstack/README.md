# SaltStack
#context

## Links
* [Embedded salt modules: salt/salt/modules](https://github.com/saltstack/salt/tree/develop/salt/modules)
* [Configuring the Salt Minion](https://docs.saltstack.com/en/latest/ref/configuration/minion.html)
* [Configuring the Salt Master](https://docs.saltstack.com/en/latest/ref/configuration/master.html)
* [Configuration file examples](https://salt.readthedocs.io/en/stable/ref/configuration/examples.html)
* [State System Reference](https://docs.saltstack.com/en/latest/ref/states/)
* 
* [GitHub - harkx/saltstack-cheatsheet: SaltStack Cheat Sheet](https://github.com/harkx/saltstack-cheatsheet)
* [GitHub - eon01/SaltStackCheatSheet: SaltStack Cheat Sheet](https://github.com/eon01/SaltStackCheatSheet)

### Common
```sh
# Here is the full version information 
salt --versions-report

# Format output
salt --out=json '*' cmd.run_all 'echo OK'
--out=nested|yaml|json|quiet|....

# Simple call
salt '*' test.ping  # Use function ping from module test

# Documentation
salt 'salt-minion-1' sys.list_functions test # List functions
salt '*' sys.list_state_functions pkg  # Functions that can be used in states
salt '*' sys.list_modules
salt '*' sys.state_doc pkg.removed
salt '*' sys.doc test.fib # Show documentation
salt '*' sys.doc test

# Minion info
salt '*' status.discusage
salt '*' status.loadavg
salt '*' status.meminfo
salt '*' status.uptime

# Commands
salt '*' cmd.run 'echo Hello!'
salt '*' cmd.run_stdout 'echo Hello!'
salt '*' cmd.run_stderr 'echo Hello!'
salt '*' cmd.retcode 'echo Hello!'
salt '*' cmd.run_all 'echo Hello!'
```

### Quickstart
```sh
salt '*' test.ping

salt '*' user.add larry
salt '*' user.info larry

salt '*' pkg.install nginx
salt '*' pkg.list_pkgs

salt '*' service.status nginx
```

### Key management
```sh
# minion
salt-call --local key.finger
# master
salt-key  # keys info
salt-key -f salt-minion-1  # show fingerprint
salt-key -a salt-minion-1  # accept key
```

### Matching
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

### Modules
```sh
sudo salt '*' saltutil.sync_all
```

### Pillar
```
# Pillar data is similar to grains except that it can be defined more dynamically and is
# a secure store for data 

salt '*' saltutil.refresh_pillar
salt '*' pillar.items
```

### Grains
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






