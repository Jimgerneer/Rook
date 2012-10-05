require 'will_paginate'
require_relative 'routes_helper'

class Rook < Sinatra::Base

  get '/' do
    @opportunities = Opportunity.paginate(:active => true, :page => params[:page], :per_page => 10)
    haml :index
  end

  get '/opportunity' do
    login_required
    haml :opportunity
  end

  get '/opportunity/messages.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    @messages = @op.recent_messages
    haml :opportunity_messages, :locals => { :title => @op.title, :opportunity => @op }
  end

  get '/opportunity/conversation.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id )
    @apprentice_id = params[:user]
    @messages = Message.all(:sender_id => session[:user]) & Message.all(:sender_id => @apprentice_id)
    haml :opportunity_conversation, :locals => { :opportunity => @op, :message => @messages, :apprentice_id => @apprentice_id }
  end

  get '/opportunity/contact.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    haml :opportunity_contact, :locals => { :title => @op.title, :opportunity => @op }
  end

  post '/opportunity/contact.:id' do |id|
    sender_id = session[:user]
    sender = User.first(:id => sender_id)
    author = User.first(:opportunities => Opportunity.all(:id => id))
    author_id = author.id
    data = {:recipient_id => author_id, :opportunity_id => id, :body => params[:body]}
    MessageService.create(sender, data)
    redirect '/'
  end

  post '/opportunity/send_message.:id' do |id|
    opportunity = Opportunity.first(:id => id)
    sender_id = session[:user]
    sender = User.first(:id => sender_id)
    opportunity_author = opportunity.user
    if sender_id == params[:user]
      recipient_id = opportunity_author.id
    else
      recipient_id = params[:user]
    end
    data = {:recipient_id => recipient_id, :opportunity_id => id, :body => params[:body]}
    MessageService.create(sender, data)
    redirect "/opportunity/conversation.#{opportunity.id}?user=#{sender_id}"
  end

  get '/opportunity/view.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    @messages = Message.all(:sender_id => session[:user]) & Message.all(:sender_id => @op.user_id)
    haml :opportunity_views, :locals => { :title => @op.title, :opportunity => @op }
  end

  get '/opportunity/edit.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    haml :opportunity_edit, :locals => { :opportunity => @op }
  end

  post '/opportunity/update.:id' do |id|
    #transforms comma seperated string into array of strings
    params[:opportunity]["skills"] = params[:opportunity].delete("skills").split(/,\s*/)
    @op = OpportunityService.update(id, params[:opportunity])
    redirect '/'
  end

  get '/opportunity/confirm_deactivate.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    haml :opportunity_deactivate, :locals => { :opportunity => @op }
  end

  get '/opportunity/deactivate.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    @op.update(:active => false)
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
