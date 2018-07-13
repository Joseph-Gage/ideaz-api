source 'https://rubygems.org'
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby '2.5.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Bcrypt for password encrypting
gem 'bcrypt', '~> 3.1.12'
# Use JWTs for token based authentication
gem 'jwt', '~> 2.1.0'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.0.2'

group :development, :test do
  gem 'rspec-rails', '~> 3.7'
end

group :development do
end

group :test do
  gem 'factory_bot_rails', '~> 4.10.0'
  gem 'shoulda-matchers', '~> 3.1.2'
  gem 'faker', '~> 1.8.7'
  gem 'database_cleaner', '~> 1.7.0'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
