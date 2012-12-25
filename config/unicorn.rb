# config/unicorn.rb
base_path = '/var/rails/tusffbschach'
# Set environment to development unless something else is specified
env = ENV["RAILS_ENV"] || "production"
worker_processes 2
listen "#{base_path}/shared/tmp/sockets/unicorn.chess.sock", :backlog => 64
preload_app true
timeout 30
pid "#{base_path}/shared/tmp/pids/unicorn.chess.pid"
if env == "production"
  working_directory "#{base_path}/current"
  user 'schachclub', 'unicorn'
  shared_path = "#{base_path}/shared"
  stderr_path "#{shared_path}/log/unicorn.stderr.log"
  stdout_path "#{shared_path}/log/unicorn.stdout.log"
end

before_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.connection.disconnect!
  end
  old_pid = "#{base_path}/shared/tmp/pids/unicorn.chess.pid.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  if defined?(ActiveRecord::Base)
    ActiveRecord::Base.establish_connection
  end
end
