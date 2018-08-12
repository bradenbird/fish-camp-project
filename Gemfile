source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'faker'
gem 'omniauth-google-oauth2', '~> 0.2.1'
gem 'roo'
gem "iconv", "~> 1.0.3"
gem 'pundit'
gem 'clearance'
gem 'bootstrap-sass'
gem 'jbuilder', '~> 2.5'
gem 'will_paginate'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'selenium-webdriver'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'cucumber-rails', :require => false
  gem 'sqlite3'
  gem 'rails-controller-testing'
  gem 'rails-erd'
end

group :test do
  gem 'capybara', '~> 2.13'
  gem 'guard-rspec'
  gem 'launchy'
  gem 'pundit-matchers', '~> 1.4.1'
  gem 'rspec-collection_matchers'
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
