require 'pry'

class Rook < Sinatra::Base
  get '/opportunity' do
    haml :opportunity
  end

  post '/opportunity' do
    @opportunity = Rook::Opportunity.create(params[:opportunity])
    #:title => params[:title],
    #:skills => params[:skills],
    #:description => params[:description]
    #)
    redirect "/"

    #haml :opportunity
  end 
end
