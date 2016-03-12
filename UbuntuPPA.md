**Contents:**


# Introduction #

A subset of our software is available for Ubuntu through a PPA for maximum portability. This page contains information about these packages, namely how to install them

# State #

The Ubuntu PPA is currently in a setup/testing phase and its location and/or availability in the short-term are subject to change without notice.


---


| 08/30/12 | Repo initialized |
|:---------|:-----------------|
| 08/31/12 | GPG keys added   |
| 11/05/12 | Dist-specific releases added |

# Installation #

Currently, the PPA can be "installed" in two steps

First, add the package list to your sources

```
sudo sh -c 'echo "deb http://robotics.usc.edu/~ekaszubski/packages/ubuntu `cat /etc/*-release | grep CODENAME | sed -e s:DISTRIB_CODENAME=::g`/" > /etc/apt/sources.list.d/usc-latest.list'
```

Then, import the PPA's GPG key and update your package index

```
wget http://robotics.usc.edu/~ekaszubski/packages/ubuntu/usc-interaction.key -O - | sudo apt-key add - \
&& sudo apt-get update
```

Packages can then be located/installed via synaptic, apt, or similar

```
sudo apt-get install <package>
```