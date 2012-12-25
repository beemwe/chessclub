Rails.root = '/home/beemwe/webspaces/schachclub/current'
Rails.env = ENV['RAILS_ENV'] || 'development'
worker_processes 2
preload_app true
timeout 30
listen Rails.root + 'tmp/sockets/unicorn.sock', :backlog => 64

before_fork do |server, worker|
  pid_old = Rails.root + 'tmp/pids/unicorn.pid.oldbin'
  if File.exists?(pid_old) && server.pid != pid_old
    begin
      Process.kill("QUIT", File.read(pid_old).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  ActiveRecord::Base.establish_connection
  begin
    uid, gid = Process.euid, Process.egid
    user, group = 'beemwe', 'beemwe'
    target_uid = Etc.getpwnam(user).uid
    target_gid = Etc.getgrnam(group).gid
    worker.tmp.chown(target_uid, target_gid)
    if uid != target_uid || gid != target_gid
      Process.initgroups(user, target_gid)
      Process::GID.change_privilege(target_gid)
      Process::UID.change_privilege(target_uid)
    end
  rescue => e
    if Rails.env == 'development'
      STDERR.puts "Cannot change Unicorn's worker UID/GID in development environment."
    else
      raise e
    end
  end
end
