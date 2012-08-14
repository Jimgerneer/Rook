require 'sinatra'
require 'dm-migrations'
require 'dm-validations'
require 'dm-timestamps'
require 'pony'

#test_rook is for unit testing

DataMapper.setup(:default, "abstract::")

#move to lib/server
class Rook  < Sinatra::Base
  set :sessions, true
  set :session_secret, 'ENV[SESSION_SECRET]'
end

#manifest file needed /lib/rook/ rook.rb
require_relative '../routes/init'
require_relative '../models/init'
require_relative '../services/init'
