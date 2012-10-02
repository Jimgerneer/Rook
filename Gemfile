source :rubygems

gem 'sinatra'
gem 'thin'
gem 'data_mapper'
gem 'haml'
gem 'dm-chunked_query'
gem 'dm-migrations'
gem 'dm-core'
gem 'dm-timestamps'
gem 'dm-validations'
gem 'dm-pager'
gem 'will_paginate', '~> 3.0.0'
gem 'pony'
gem 'pony-test', git: 'https://github.com/johnmendonca/pony-test.git'
gem 'sinatra-flash'
gem 'bowtie', git: 'https://github.com/DecoyDrone/bowtie.git'

group :production do
  gem 'dm-postgres-adapter'

end

group :development, :test do
  gem 'dm-mysql-adapter'
  gem 'webrat'
  gem 'database_cleaner'
  gem 'mocha'
  gem 'dm-sweatshop'
  gem 'shotgun'
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'rack-test'
  gem 'pry-nav'
  gem 'rake'
  gem 'cucumber'
  #if RUBY_PLATFORM =~ /darwin/i
    gem 'guard-minitest'
    gem 'growl'
    gem 'growl_notify'
    gem 'rb-fsevent', :require => false
  #end
  gem 'minitest-reporters'
  gem 'ruby_gntp'
  #gem 'guard-livereload' #guard init livereload #also install live reload ext in browser
end
