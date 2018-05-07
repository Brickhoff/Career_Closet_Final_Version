source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.4.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.4'
# Use sqlite3 as the database for Active Record

# Use Puma as the app server (for local but not c9 system)
#gem 'puma', '3.11.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.6'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '4.1.5'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.1.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'bcrypt',                  '3.1.11'
gem 'faker',                   '1.7.3'
gem 'carrierwave',             '1.2.2'
gem 'mini_magick',             '4.7.0'
gem 'will_paginate',           '3.1.6'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'bootstrap-sass',          '3.3.7'
gem 'jquery-rails',            '4.3.1'
#gem 'simple_form'
gem 'guard-rspec'
# Use ransack for Search 
gem 'ransack', github: 'activerecord-hackery/ransack'
# Use for backgroud processing
gem 'sidekiq'
# Redis-backed Ruby library for creating background jobs
gem 'resque'
# A light-weight job scheduling system built on top of resque
gem 'resque-scheduler'


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'#, '~> 2.18.0'
  gem 'guard-rspec'
  gem 'selenium-webdriver'
  gem 'sqlite3', '1.3.13'
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem "factory_girl_rails", "~> 4.4.1"
  gem 'rails-controller-testing'
end

group :development do
  
  gem 'web-console',           '3.5.1'
  gem 'listen',                '3.1.5'
  gem 'spring',                '2.0.2'
  #gem 'spring-watcher-listen', '2.0.1'
end

group :test do
  # gem 'rails-controller-testing', '1.0.2'
  # gem 'minitest-reporters',       '1.1.14'
  # gem 'guard',                    '2.14.1'
  # gem 'guard-minitest',           '2.4.6'
  gem 'simplecov', :require => false
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'
  gem 'launchy'
  gem 'email_spec'
end

group :production do
  gem 'pg',  '0.20.0'
  gem 'fog', '1.42'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
