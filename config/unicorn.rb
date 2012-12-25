root = '/var/rails/tusffbschach/current'
env = ENV['RAILS_ENV'] || 'production'
worker_processes 2
preload_app true
timeout 30
listen root + 'tmp/sockets/unicorn.sock', :backlog => 64
pid "/var/rails/tusffbschach/shared/tmp/pids/unicorn.schachclub.pid"

# Production specific settings
if env == "production"
  # Help ensure your application will always spawn in the symlinked
  # "current" directory that Capistrano sets up.
  working_directory "/var/rails/tusffbschach/current"

  # feel free to point this anywhere accessible on the filesystem
  user 'schachclub', 'unicorn'
  shared_path = "/var/rails/tusffbschach/shared"

  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end



before_fork do |server, worker|
  # the following is highly recomended for Rails + "preload_app true"
  # as there's no need for the master process to hold a connection
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end

  # Before forking, kill the master process that belongs to the .oldbin PID.
  # This enables 0 downtime deploys.
  old_pid = "/var/rails/tusffbschach/shared/tmp/pids/unicorn.schachclub.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
end
