source 'https://rubygems.org'

gem 'unicorn'

gem 'petfinder'

gem 'rails', '4.1.4'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.0'

gem 'spring',        group: :development

gem "mongoid", "~> 4.0.0"

gem 'grape'
gem 'grape-rabl'
gem 'rack-cors'

gem 'awesome_print', :git => "https://github.com/MarcinCebula/awesome_print.git"

group :development, :test do
  gem 'byebug'
  gem 'pry-byebug'
  gem 'pry-theme'

  gem 'spring-commands-rspec'

  gem 'factory_girl_rails'
  gem 'better_errors'
  gem 'quiet_assets'

  gem 'database_cleaner'
  gem 'shoulda-matchers'

  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'terminal-notifier-guard'
end

group :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-mocks'
  gem "rspec-sidekiq"
  gem 'mongoid-rspec'
end
