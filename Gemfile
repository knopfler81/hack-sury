source 'https://rubygems.org'
ruby '2.3.3'

gem 'rails', '5.0.1'
gem 'puma'
gem 'pg'
gem 'figaro'
gem 'jbuilder', '~> 2.0'
gem 'devise'
gem 'redis'
gem 'omniauth-facebook'
gem 'bootstrap-datepicker-rails'
gem 'sass-rails'
gem 'jquery-rails'
gem 'uglifier'
gem 'bootstrap-sass'
gem 'font-awesome-sass'
gem 'simple_form'
gem 'autoprefixer-rails'
gem 'geocoder'
gem "coffee-rails"
gem "gmaps4rails"
gem "cocoon"
gem 'money-rails'
gem 'stripe'
gem 'faker'
gem 'cloudinary', '1.1.7'
gem 'attachinary', github: 'assembler/attachinary'
gem 'jquery-fileupload-rails'
gem 'coffee-rails'

group :development, :test do
  gem 'binding_of_caller'
  gem 'better_errors'
  gem 'awesome_print'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'spring'
  gem 'listen', '~> 3.0.5'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem "rails-erd"
end

group :test do
  gem 'capybara-webkit' #navigateur simultaion du comportement user
  gem 'database_cleaner' #vider la DB entre chaque test
  gem 'factory_girl_rails' #creer des ressources facilement = seed modifiables à  la volée.
  gem 'rspec-rails' 
  gem 'shoulda-matchers' #expectation methode plus lisibles => relations spécifiée (it should belong_to...)
  gem 'simplecov', require: false #savoir le tx de couverture des tests
  gem 'webmock' # garanti la neutralité des tests 
end

source 'https://rails-assets.org' do
  gem "rails-assets-underscore"
end
