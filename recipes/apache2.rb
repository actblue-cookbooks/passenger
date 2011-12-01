# This is just to get the prereqs for the actual passenger apache
# module build. Mostly it's split up since the LWRP can't call
# include_recipe directly.
# http://tickets.opscode.com/browse/CHEF-611?focusedCommentId=20492

  # dependancies
  if platform?("centos","redhat")
    package "httpd-devel"
  else
    %w{ apache2-prefork-dev libapr1-dev libcurl4-openssl-dev }.each do |pkg|
      package pkg do
        action :install
      end
    end
  end
