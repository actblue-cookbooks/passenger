action :create do
  gem_package "passenger (#{new_resource.gem})" do
    gem_binary new_resource.gem
    package_name 'passenger'
    version new_resource.version
  end

#  unless new_resource.options[:bundler_skip]
#    gem_package "bundler (#{new_resource.gem})" do
#      package_name 'bundler'
#      version new_resource.options[:bundler_version]
#    end
#  end

end

