# Various bits of the passenger configuration need to know the full
# path to things. But when we install passenger, the only thing we
# tell is is the gem path. These functions will start with a gem
# command, and find the desired things.

#class Chef
#  class Recipe

    def passenger_find_executable(executable, gem="/usr/bin/gem", version=nil)
      # this has an unfortunate amount of hacking around gem bogusity.
      # sometimes gem returns an absolute path, sometime it does
      # not. So we're going to canonicalize it.
      version_arg = version.nil? ? "" : "--version '#{version}'"
      bin = `#{gem} contents passenger #{version_arg}`.split("\n").select { |i| i.match("bin/#{executable}$") }.first
      if bin.nil?
        return nil
      elsif bin.match("^/")
        return bin
      else
        gemdir = `#{gem} environment`.split("\n").map { |i| i.gsub!(/.*INSTALLATION DIRECTORY:\s*/, "") }.compact
        return ::File.join(gemdir, bin)
      end
    end

    def passenger_find_bindir(gem="/usr/bin/gem", version=nil)
      `#{gem} environment`.split("\n").map { |i| i.gsub!(/.*EXECUTABLE DIRECTORY:\s*/, "") }.compact.first
    end


    def passenger_find_root_path(gem="/usr/bin/gem", version=nil)
      pc = passenger_find_executable("passenger-config", gem, version)
      `#{pc} --root`.chomp
    end

    def passenger_module_path(gem="/usr/bin/gem", version=nil)
      passenger_find_root_path(gem, version) + "/ext/apache2/mod_passenger.so"
    end


    def passenger_find_ruby_path(gem="/usr/bin/gem", version=nil)
      `#{gem} environment`.split("\n").map { |i| i.gsub!(/.*RUBY EXECUTABLE:\s*/, "") }.compact
    end


#  end
#end
