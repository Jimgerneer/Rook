require 'pry'
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

  get '/opportunity/edit.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_edit, :locals => { :title => "Edit Opportunity", :opportunity => @op }
  end

  post '/opportunity/update.:id' do |id|
    #transforms comma seperated string into array of strings
    params[:opportunity]["skills"] = params[:opportunity].delete("skills").split(/,\s*/)
    @op = OpportunityService.update(id, params[:opportunity])
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

  post '/opportunity' do
    #transforms comma seperated string into array of strings
    params[:opportunity]["skills"] = params[:opportunity].delete("skills").split(/,\s*/)
    @opportunity = OpportunityService.create(current_user, params[:opportunity])
    redirect "/user"
  end 

  post '/bookings' do
    params[:opportunity]
    @booking = Booking.create!(:opportunity_id => params[:opportunity],
                              :user_id => session[:user])
    redirect '/user'
  end
end
