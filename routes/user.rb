class Rook < Sinatra::Base
  get '/'  do
    haml :index
  end
end

