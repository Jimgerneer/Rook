require 'will_paginate'
require 'pry'
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

  get '/opportunity/edit.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_edit, :locals => { :title => "Edit Opportunity", :opportunity => @op }
  end

  post '/opportunity/update.:id' do |id|
    @op = Opportunity.first(:id => id)
    @op.update(params[:opportunity])
    redirect '/'
  end

  get '/opportunity/delete.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_delete, :locals => { :title => "Confirm Delete", :opportunity => @op }
  end

  get '/opportunity/destroy.:id' do |id|
    @op = Opportunity.first(:id => id)
    @op.destroy
    redirect '/'
  end

  post '/bookings' do
    params[:opportunity]
    @booking = Booking.create!(:opportunity_id => params[:opportunity],
                              :user_id => session[:user])
    redirect '/user'
  end

  post '/opportunity' do
    opportunity_params = params[:opportunity].merge(:user => current_user)
    @opportunity = Opportunity.create!(opportunity_params)
    redirect "/user"
  end 
end
