require 'will_paginate'
require_relative 'routes_helper'

class Rook < Sinatra::Base
  get '/' do
    @opportunities = Opportunity.paginate(:page => params[:page], :per_page => 10)

    haml :index
  end

  get '/opportunity' do
    login_required
    haml :opportunity
  end

  post '/opportunity' do
    opportunity_params = params[:opportunity].merge(:user => current_user)
    @opportunity = Opportunity.create!(opportunity_params)
    redirect "/"
  end 
end
