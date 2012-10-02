require File.join(File.dirname(__FILE__), 'rook.rb')
require 'bowtie'

map "/admin" do
  BOWTIE_AUTH = {:user => ENV['ADMIN_USER'], :pass => ENV['ADMIN_PASSWORD'] }
  run Bowtie::Admin
end

run Rook.new
