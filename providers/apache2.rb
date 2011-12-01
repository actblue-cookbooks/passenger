action :create do

  passenger_install "passenger/#{new_resource.version} for apache2 (#{new_resource.gem})" do
    version new_resource.version
    gem new_resource.gem
  end

  bash "install passenger/apache2 (#{new_resource.gem}" do
    user "root"
    code "#{passenger_find_executable("passenger-install-apache2-module", new_resource.gem, new_resource.version)} --auto"
    environment({ 'PATH' => "#{passenger_find_bindir(new_resource.gem, new_resource.version)}:/usr/bin:/bin:/usr/sbin:/sbin" })
    creates passenger_module_path(new_resource.gem, new_resource.version)
  end

  if ::File.exists?(passenger_find_root_path(new_resource.gem, new_resource.version) )

    # Generate the apache snippet by asking passenger to do it for us.
    # This is a little weird, since it will use the first ruby on your
    # path, *not* the one it was compiled with. (WTF poassenger)
    # Luckily, it looks like we can just call it with an explicit ruby
    # to get the desired behavior.
    template "#{node[:apache][:dir]}/mods-available/passenger.load" do
      cookbook "passenger"
      source "apache.load.erb"
      owner "root"
      group "root"
      mode 0644
      variables( 
                :bin => [
                         passenger_find_ruby_path(new_resource.gem, new_resource.version),
                         passenger_find_executable("passenger-install-apache2-module", new_resource.gem, new_resource.version),
                        ].join(" ")
                )
    end

    template "#{node[:apache][:dir]}/mods-available/passenger.conf" do
      cookbook "passenger"
      source "apache.conf.erb"
      owner "root"
      group "root"
      mode 0644
    end

    apache_module "passenger"

  end

end

