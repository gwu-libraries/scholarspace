source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3'
# Use PostgreSQL as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Make jquery and Turbolinks play nice
gem 'jquery-turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use sitemap to generate sitemap
gem 'sitemap'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem 'sufia', '6.6.1'

# Use Omniauth-Shibboleth for authentication federation
gem 'omniauth-shibboleth'

gem 'kaminari', github: 'jcoyne/kaminari', branch: 'sufia'  # required to handle pagination properly in dashboard. See https://github.com/amatsuda/kaminari/pull/322


gem "rsolr", "~> 1.0.6"
gem "devise"
gem "devise-guests", "~> 0.3"
group :development, :test do
  gem "rspec-rails"
  gem "jettywrapper"
end

gem 'hydra-role-management'

# See https://github.com/projecthydra/sufia/commit/6a2f8ae03b93b14389971df7907b88d7d3044043#diff-bdf3765bf1682c8aba719dba2e632b54R33 for reason for constraining the active-fedora version below 9.8.  Remove this for Sufia 7.
gem 'active-fedora', '~> 9.4', '< 9.8'
