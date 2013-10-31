set :stages, %w(production staging)
set :default_stage, 'staging'
# require 'capistrano/ext/multistage'

set :application, 'tusffbschach'
set :repo_url, 'git://github.com/beemwe/chessclub.git'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, :master

# set :deploy_to, '/var/www/my_app'
set :scm, :git

set :format, :pretty
set :log_level, :debug # :info # :debug
set :pty, true

# set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 3

# RVM Settings
set :rvm_type, :system
set :rvm_ruby_version, '1.9.3-p327'
set :rails_env, 'staging'
# set :rvm_custom_path, '~/.myveryownrvm'

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute 'service unicorn-tusffbschach_staging upgrade'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
