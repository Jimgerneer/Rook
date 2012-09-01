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

  get '/opportunity/messages.:id' do |id|
    @op = Opportunity.first(:id => id)
    @users = User.all(:messages_sent => Message.all(:opportunity_id => @op.id))
    #@messages = Message.all(:opportunity_id => @op.id)

    haml :opportunity_messages, :locals => { :title => @op.title, :opportunity => @op }
  end

  get '/opportunity/contact.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_contact, :locals => { :title => @op.title, :opportunity => @op }
  end

  post '/opportunity/contact.:id' do |id|
    sender_id = session[:user]
    sender = User.first(:id => sender_id)
    author = User.first(:opportunities => Opportunity.all(:id => id))
    author_id = author.id
    data = {"recipient_id" => author_id, "opportunity_id" => id}
    MessageService.create(sender, data)
    redirect '/'
  end

  get '/opportunity/view.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_views, :locals => { :title => @op.title, :opportunity => @op }
  end

  get '/opportunity/edit.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_edit, :locals => { :opportunity => @op }
  end

  post '/opportunity/update.:id' do |id|
    #transforms comma seperated string into array of strings
    params[:opportunity]["skills"] = params[:opportunity].delete("skills").split(/,\s*/)
    @op = OpportunityService.update(id, params[:opportunity])
    redirect '/'
  end

  get '/opportunity/delete.:id' do |id|
    @op = Opportunity.first(:id => id)
    haml :opportunity_delete, :locals => { :opportunity => @op }
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

  post '/opportunity/book.:id' do |id|
    @booking = Booking.create!(:opportunity_id => id,
                              :user_id => params[:user])
    redirect '/user'
  end
end
