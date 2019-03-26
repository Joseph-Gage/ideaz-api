source 'https://rubygems.org'
git_source(:github) {|repo| "https://github.com/#{repo}.git"}

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use Bcrypt for password encryptings
gem 'bcrypt', '~> 3.1.12'
# Use JWTs for token based authentication
gem 'jwt', '~> 2.1.0'
# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'
# Use cancancan for rights
gem 'cancancan', '~> 2.0'
# Use olive branch for transforming keys between camel case and snake case
gem 'olive_branch', '~> 2.1.3'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors', '~> 1.0.2'

group :development, :test do
  gem 'rspec-rails', '~> 3.8.0'
end

group :development do
end

group :test do
  gem 'database_cleaner', '~> 1.7.0'
  gem 'factory_bot_rails', '~> 4.11.1'
  gem 'faker', '~> 1.9.1'
  gem 'shoulda-matchers', '~> 4.0.0.rc1'
  gem 'simplecov', '~> 0.16.1'
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
