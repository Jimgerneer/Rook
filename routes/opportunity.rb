class Rook < Sinatra::Base
  get '/opportunity' do
    haml :opportunity
  end

  post '/opportunity' do
    @title = params[:title] 
    @skills = params[:skills]
    @description = params[:description]

    haml :opportunity
  end 
end
