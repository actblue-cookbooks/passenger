# config settings
default[:passenger][:conf][:max_pool_size] = 10
default[:passenger][:conf][:max_requests] = 20000

# Prevent the preloader from shutting down.
# Default value is 300 (seconds) / 5 minutes
# Non-zero values useful to save memory on shared servers
# but less useful on dedicated application servers like Indigo
# Non-zero values combined with non-zero MaxRequests settings can result
# in slow forking since the preloader could be shut down when the
# MaxRequests restart/fork happens
default[:passenger][:conf][:max_preloader_idle_time] = 0

default[:passenger][:conf][:min_instances] = 2
default[:passenger][:conf][:max_instances_per_app] = 0
#default[:passenger][:conf][:pool_idle_time]
default[:passenger][:conf][:user_switching] = "off"
