require 'pry'
require 'will_paginate'

class Rook < Sinatra::Base
  get '/' do
    @opportunites = Rook::Opportunity.paginate(:page => params[:page], :per_page => 10)
#   @opportunites = paginate(Rook::Opportunity)

    haml :index
  end

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
