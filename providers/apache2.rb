action :create do

  #Chef::Recipe::include_recipe "apache2"

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

  passenger_install "passenger/#{new_resource.version} for apache2 (#{new_resource.gem})" do
    version new_resource.version
    gem new_resource.gem
  end

  bash "install passenger/apache2 (#{new_resource.gem}" do
    user "root"
    code "#{passenger_find_executable("passenger-install-apache2-module", new_resource.gem, new_resource.version)} --auto"
    creates passenger_module_path(new_resource.gem, new_resource.version)
  end

  template "#{node[:apache][:dir]}/mods-available/passenger.load" do
    cookbook "passenger"
    source "apache.load.erb"
    owner "root"
    group "root"
    mode 0644
    variables( :bin => passenger_find_executable("passenger-install-apache2-module", new_resource.gem, new_resource.version) )
    only_if do ::File.exists?(passenger_find_root_path(new_resource.gem, new_resource.version) ) end
  end



end

