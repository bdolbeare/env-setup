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
./mac/setup-osx.sh
./mac/setup-brew.sh
./mac/setup-tmux.sh
./mac/setup-powerline.sh
```

## Script Summary

**setup-osx.sh** run this command to update the OS, install XCode, and to write system defaults which control OS and applications settings/preferences. [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/setup-osx.sh)

**setup-brew.sh** run this command to install brew, upgrade any existing brew formulae, and install some common tools and applications. [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/setup-brew.sh)

**setup-tmux.sh** run this command to configure tmux with some preferred plugins. [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/setup-tmux.sh)

**setup-powerline.sh** run this command to install the Powerline fonts which I like to use in tmux [view source](https://github.com/bdolbeare/env-setup/tree/master/mac/setup-powerline.sh)

## Reference Links

[The Tao of tmux](https://leanpub.com/the-tao-of-tmux/read#config)</br>
[tmuxinator](https://github.com/tmuxinator/tmuxinator)</br>
[tmux cheat sheat](https://gist.github.com/MohamedAlaa/2961058)</br>
[xpanes](https://github.com/greymd/tmux-xpanes)</br>
