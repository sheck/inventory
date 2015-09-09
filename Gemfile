source 'https://rubygems.org'

ruby "2.2.2"

gem 'rails', '4.2.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'sdoc', '~> 0.4.0', group: :doc

group :production do
  gem 'pg'
  gem 'rails_12factor'
end

gem 'clearance'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'paperclip', '~> 4.3'
gem 'aws-sdk', '~> 1.6'

source 'https://rails-assets.org' do
  gem 'rails-assets-fontawesome', '4.1.0'
  gem 'rails-assets-tablesaw'
end

group :development, :test do
  gem 'sqlite3'
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'

  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'poltergeist'
  gem 'factory_girl_rails'

  gem 'guard-livereload', '~> 2.4', require: false
  gem 'rack-livereload'

  gem 'launchy'
  gem 'figaro'
end

group :test do
  gem 'shoulda-matchers'
end
