source 'http://rubygems.org'

gem 'rails', '~> 3.2.0'
gem 'json'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
# gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'bcrypt-ruby', '~> 3.0.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.0"
  gem 'coffee-rails', "~> 3.2.0"
  gem 'uglifier'
end

gem 'haml-rails'
gem 'simple_form'
gem 'acts_as_list'
gem 'acts-as-taggable-on', '~>2.2.0'
gem 'will_paginate', '~> 3.0.0'
gem 'declarative_authorization'
gem 'RedCloth'
gem 'jquery-rails'
gem 'paperclip', '~>2.7.0'
if RUBY_VERSION > "1.9"
    gem 'ruby-debug19'
else
    gem 'ruby-debug'
end

group :development, :test do
  gem 'therubyracer'

  gem 'machinist'
  gem 'faker'
  gem 'rspec-rails'
  gem 'shoulda-matchers'

  gem 'capybara'
  gem 'database_cleaner'
  gem 'cucumber-rails'
  gem 'spork', '~> 1.0.0.rc'
  gem 'launchy'
  gem 'pickle'
  gem 'nifty-generators'

  gem 'mocha'
  gem 'simplecov', '>= 0.5.2', :require => false, :group => :test
  gem 'ruby_parser'
end

