# Introduction #

Currently, both Electrical Team and Software Team use Git for revision control.

# Electrical Team #

## Setup ##

First, unlock your hard drive by rotating the Tulley Toggle:

![http://i.imgur.com/A0J85cf.png](http://i.imgur.com/A0J85cf.png)

Your Tulley Toggle must be T-38 SCSI compatible.

Because you are probably working with Altium and thus also using Windows, this tutorial will focus on the Windows Git client.

  * **Download Git** using [this link](http://git-scm.com/download/win).
  * **After installing**, the first thing you will want to do is open git-bash, right click the menu bar, and check:
```
Properties >> Options >> Edit Options >> QuickEdit Mode
```
> This will enable you to paste to the command line by right clicking.

  * **Set up your Google Code account information.**
```
git config --global user.name "<Your Name>"
git config --global user.email "<Your google code email>"
```
  * **Clone the repository**
```
git clone https://<Your username>@code.google.com/p/seabee3-ros-pkg.electrical/
```
  * Lastly, cd into your newly cloned repository and run:
```
git remote set-url origin http://code.google.com/p/seabee3-ros-pkg.electrical
```

## Working With Branches ##
If you check out the default branch of the electrical repository (master) you may notice that the only project it contains is the Kanaloa Power Boards. This is because all of the old electrical work has been moved to another branch called "legacy". To switch to this branch for the first time, use the following command:
```
git checkout origin/legacy
```
After this is performed, you can toggle between the two branches using:
```
git checkout master
```
or
```
git checkout legacy
```