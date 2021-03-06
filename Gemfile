source 'https://rubygems.org'

gem 'unicorn'

gem 'rails', '4.1.4'
gem 'uglifier', '>= 1.3.0'
gem 'jbuilder', '~> 2.0'

gem 'spring',        group: :development

gem "mongoid", "~> 4.0.0"
gem "mongoid-pagination"
gem 'grape'
gem 'grape-rabl'
gem 'rack-cors'

gem 'awesome_print', :git => "https://github.com/MarcinCebula/awesome_print.git"

gem 'faraday'
gem 'excon'

group :development, :test do
  gem 'faraday'
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

  gem 'curb'
end

group :test do
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-mocks'
  gem "rspec-sidekiq"
  gem 'mongoid-rspec'

  gem 'vcr'
  gem 'webmock', :git => 'https://github.com/bblimke/webmock.git', :branch => 'master'
end
