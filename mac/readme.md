# Macbook Setup

![Macbook Setup](http://macdown.uranusjr.com/static/images/logo-160.png)

This project provides a set of scripts that can be used to configure a Macbook with a common set of applications, command-line-utilities, and system settings/preferences.



## Steps

Step 1: Clone the git repo:

```
git clone git@github.com:bdolbeare/env-setup.git
```


Step 2:  Run the setup scripts:

```
./mac/osx-setup.sh
./mac/brew.sh
./mac/setup.sh (include -f option to avoid prompting)
```

## Script Summary

**osx-setup.sh** run this command to update the OS, install XCode, and to write system defaults which control OS and applications settings/preferences. [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/osx-setup.sh)

**brew.sh** run this command to install brew, upgrade any existing brew formulae, and install some common tools and applications. [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/brew.sh)

**setup.sh** run this command to copy configuration files (e.g. .bashrc, .aliases, .gitconfig, etc.) to your home directory [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/setup.sh)

