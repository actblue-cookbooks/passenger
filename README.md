# Intro #

This is a cookbook to install passenger. I had originally been using a
[fork](https://github.com/actblue/cookbooks-jamesotron) of
[jamesotron](https://github.com/jamesotron/cookbooks)'s passenger
cookbook. But then I decided `rvm` needed to be thrown off the
island. Doing so was going to cause incompatible changes, and it
seemed better to just start clean.

Basically, it gets really weird trying to support custom rubies.


# Usage #

This is based on a LWRP model for installing passenger. This easily
allows you to call it with a custom ruby. Or multiple custom rubies.
