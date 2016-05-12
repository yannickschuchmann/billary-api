source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '>= 5.0.0.beta3', '< 5.1'

gem 'active_model_serializers', git: "https://github.com/rails-api/active_model_serializers.git"

# User auth
gem 'devise', git: "https://github.com/plataformatec/devise.git", tag: "v4.0.0.rc2"
gem 'devise_token_auth', :git => 'https://github.com/lynndylanhurley/devise_token_auth.git', :branch => 'master'
gem 'omniauth'

# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.0'
# Action Cable dependencies for the Redis adapter
gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'
gem 'figaro'

gem 'mailgun_rails'

gem 'money-rails'

gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem 'rubyzip'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rails-console'
  gem 'capistrano-bundler', require: false
  #gem 'capistrano3-puma',   require: false
  gem 'capistrano3-puma', github: "seuros/capistrano-puma", ref: "19a573e", require: false
  gem 'awesome_print', require: "ap"
  gem "rails-erd"
end


group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
