# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg'
gem 'rails', '~> 7.0'

gem 'sprockets-rails'
# Use Puma as the app server
gem 'importmap-rails'
gem 'puma', '~> 5.5.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
gem 'aws-sdk-secretsmanager', require: false
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
# gem 'bootsnap', '>= 1.4.2', require: false
gem 'haml-rails'

# user log
gem 'ahoy_matey'

# Use Devices for user authentication
gem 'aws-sdk-s3'
gem 'devise'
gem 'kaminari'
gem 'simple_form'

# graphql
gem 'devise_token_auth'
gem 'graphql'
gem 'graphql_devise'

gem 'newrelic_rpm'
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'graphql-rails_logger'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'letter_opener'
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'better_errors'
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-db-tasks', require: false
  gem 'capistrano-rails', '~> 1.1', require: false
  gem 'capistrano-rvm',   '~> 0.1', require: false
  gem 'elbas'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sshkit-sudo'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'database_cleaner-active_record'
  gem 'factory_bot_rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'graphiql-rails', group: :development
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'rspec-rails'
gem 'rubocop-performance'
gem 'rubocop-rails'
gem 'tailwindcss-rails', '~> 2.0'
