# Change these
# By default your port will be 22
server '34.221.39.18', port: 22, roles: [:web, :app, :db], primary: true

set :repo_url,        'git@bitbucket.org:lapenz/calendar.git'
set :application,     'calendar'
set :user,            'ec2-user'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             false
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.access.log"
set :puma_error_log,  "#{release_path}/log/puma.error.log"
set :ssh_options,     { forward_agent: false, user: fetch(:user), keys: %w(~/lucas.pem) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true  # Change to false when not using ActiveRecord
set :tmp_dir, "/home/#{fetch(:user)}/cap-tmp"

set :sidekiq_role, :app
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
set :sidekiq_env, 'production'

SSHKit.config.command_map[:sidekiq] = "source ~/.bash_profile && bundle exec sidekiq"
SSHKit.config.command_map[:sidekiqctl] = "source ~/.bash_profile && bundle exec sidekiqctl"

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
set :linked_files, %w{config/database.yml config/master.key}
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
 desc 'Create Directories for Puma Pids and Socket'
 task :make_dirs do
  on roles(:app) do
   execute "mkdir #{shared_path}/tmp/sockets -p"
   execute "mkdir #{shared_path}/tmp/pids -p"
  end
 end

 before :start, :make_dirs
end

namespace :deploy do
 desc "Make sure local git is in sync with remote."
 task :check_revision do
  on roles(:app) do
   unless `git rev-parse HEAD` == `git rev-parse origin/master`
    puts "WARNING: HEAD is not the same as origin/master"
    puts "Run `git push` to sync changes."
    exit
   end
  end
 end

 desc 'Initial Deploy'
 task :initial do
  on roles(:app) do
   invoke 'deploy'
  end
 end

 before :starting,     :check_revision
 after  :finishing,    :compile_assets
 after  :finishing,    :cleanup
 after  :finishing,    :restart
end

# ps aux | grep puma    # Get puma pid
# kill -s SIGUSR2 pid   # Restart puma
# kill -s SIGTERM pid   # Stop puma