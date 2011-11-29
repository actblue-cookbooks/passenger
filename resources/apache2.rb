def initialize(*args)
  super
  @action = :create
end
actions :create

attribute :name, :kind_of => String, :name_attribute => true
attribute :gem, :kind_of => String, :default => "/usr/bin/gem"
attribute :version, :kind_of => String, :default => nil
attribute :options, :kind_of => Hash, :default => {}
