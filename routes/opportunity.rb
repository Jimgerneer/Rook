class Rook < Sinatra::Base
  get '/opportunity' do
    haml :opportunity
  end
end
