# Intro #

This is a cookbook to install passenger. I had originally been using a
[fork](https://github.com/actblue/cookbooks-jamesotron) of
[jamesotron](https://github.com/jamesotron/cookbooks)'s passenger
cookbook. But then I decided `rvm` needed to be thrown off the
island. Doing so was going to cause incompatible changes, and it
seemed better to just start clean.

Basically, it gets really weird trying to support custom rubies. So,
LWRP.


# Usage #

This is based on a LWRP model for installing passenger. This easily
allows you to call it with a custom ruby. Or multiple custom rubies.

Install passenger:

    passenger_install "passenger (/my/funny/ruby/bin/gem)" do
      gem "/my/funny/ruby/bin/gem"
    end

Install passenger's apache module (this will also install passenger):

    include_recipe "passenger::apache2"
    passenger_apache2 "passenger (/my/funny/ruby/bin/gem)" do
      gem "/my/funny/ruby/bin/gem"
    end

You should be able call `passenger_install` multiple times (once per
gem). Though I did not build support for multiple apaches, so you can
really only call passenger_apache2 once.
