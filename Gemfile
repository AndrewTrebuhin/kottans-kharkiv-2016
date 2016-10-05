source "https://rubygems.org"

ruby '2.3.0'

gem 'sinatra', '1.4.7'
gem 'data_mapper'
gem 'attr_encrypted', '~> 3.0.0'

group :production do
  gem 'pg'
  gem 'dm-postgres-adapter'
end

group :development do
  gem 'dm-sqlite-adapter'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
end