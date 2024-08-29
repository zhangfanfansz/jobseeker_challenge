# frozen_string_literal: true

# config valid for current version and patch releases of Capistrano
lock '~> 3.11.0'

set :application, 'project name'
set :repo_url,  "git@bitbucket.org:pixelforcesys/#{fetch(:application)}.git"
set :deploy_to, "/home/ubuntu/#{fetch(:application)}"
set :user,      'ubuntu'
set :assets_manifests, -> { [release_path.join('public', 'packs', 'manifest.json*')] }
# Default branch is :master
set :rvm_ruby_version, '2.6.4'
set :puma_preload_app,        true
set :puma_worker_timeout,     nil
set :puma_init_active_record, true
set :puma_control_app,        true

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
append :linked_files, 'config/database.yml'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'

# Default value for default_env is {}
# set :default_env, { path: '/opt/ruby/bin:$PATH' }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure
