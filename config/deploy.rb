# frozen_string_literal: true

lock '~> 3.16.0'

set :application, 'ohisama_app'
set :repo_url, 'git@github.com:taik0527/ohisama_app.git'
set :user, 'taiki'
set :deploy_to, '/var/www/ohisama_app'
set :linked_files, %w[config/master.key config/database.yml]
set :linked_dirs, %w[log tmp/pids tmp/cache tmp/sockets public/system vendor/bundle]
set :rbenv_ruby, '3.0.2'
set :puma_threds, [4, 16]
set :puma_workers, 0
set :puma_bind, 'unix:///var/www/ohisama_app/shared/tmp/sockets/puma.sock'
set :puma_state, '/var/www/ohisama_app/shared/tmp/pids/puma.state'
set :puma_pid, '/var/www/ohisama_app/shared/tmp/pids/puma.pid'
set :puma_access_log, '/var/www/ohisama_app/shared/log/puma.error.log'
set :puma_error_log, '/var/www/ohisama_app/shared/log/puma.access.log'
set :nginx_downstream_uses_ssl, false
set :puma_preload_app, true
set :pty, true

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute 'mkdir /var/www/ohisama_app/shared/tmp/sockets -p'
      execute 'mkdir /var/www/ohisama_app/shared/tmp/pids -p'
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc 'upload important files'
  task :upload do
    on roles(:app) do
      sudo :mkdir, '-p', '/var/www/ohisama_app/shared/config'
      sudo %(chown -R #{fetch(:user)}.#{fetch(:user)} /var/www/#{fetch(:application)})
      sudo :mkdir, '-p', '/etc/nginx/sites-enabled'
      sudo :mkdir, '-p', '/etc/nginx/sites-available'

      upload!('config/database.yml', '/var/www/ohisama_app/shared/config/database.yml')
      upload!('config/master.key', '/var/www/ohisama_app/shared/config/master.key')
    end
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do
      with rails_env: fetch(:rails_env) do
        within release_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  before :starting, :upload
  before 'check:linked_files', 'puma:nginx_config'
end

after 'deploy:published', 'nginx:restart'
before 'deploy:migrate', 'deploy:db_create'
