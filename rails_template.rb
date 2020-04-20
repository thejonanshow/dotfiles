gem_group :development, :test do
  gem "dotenv-rails"
  gem "pry-byebug"
  gem "faker"
  gem "fabrication"
  gem "rspec-rails"
end

run "bundle install"

generate :controller, "home index"
route "root to: 'home#index'"

generate "rspec:install"
