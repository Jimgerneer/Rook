require 'will_paginate'
require_relative 'routes_helper'

class Rook < Sinatra::Base

  get '/' do
    if logged_in?
      check_for_messages
      @user_opportunities = Opportunity.all(:user_id => session[:user], :active => true)
      @booked_opportunities = current_user.booked_opportunities
      @contacted_opportunities = Opportunity.all(:active => true, :messages => { :sender => current_user }) - Opportunity.all(:user => current_user)
    end
    pass unless request.xhr?
    @content = false
    haml params[:subview].to_sym, :layout => false
  end

  get '/' do
    @opportunities = Opportunity.paginate(:active => true, :page => params[:page], :per_page => 10)
    @content = true
    haml :index
  end

  get '/opportunity' do
    login_required
    haml :opportunity
  end

  get '/opportunity/messages.:id' do |id|
    check_for_messages
    login_required
    @op = Opportunity.first(:id => id)
    @messages = @op.recent_messages
    haml :opportunity_messages, :locals => { :title => @op.title, :opportunity => @op }
  end

  get '/opportunity/conversation.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id )
    if @op.user == current_user
      @receiver = params[:user]
      @mentee = User.first(:id => params[:user])
    else
      @receiver = @op.user.id
      @mentee = User.first(:id => session[:user])
    end
    @messages = Message.all(:opportunity => @op)
    @messages_unviewed = Message.all(:opportunity => @op, :sender_id => @receiver, :recipient_id => current_user.id, :viewed => false)
    haml :opportunity_conversation, :locals => { :opportunity => @op,
                                                 :receiver => @receiver,
                                                 :mentee => @mentee }
  end

  after '/opportunity/conversation.:id' do
    MessageService.set_to_viewed(@messages_unviewed)
  end

  get '/opportunity/vetting.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id )
    if @op.user == current_user
      @receiver = params[:user]
    else
      @receiver = @op.user.id
    end
    @messages = Message.all(:opportunity => @op)
    @messages_unviewed = Message.all(:opportunity => @op, :sender_id => @reciever, :recipient_id => current_user.id, :viewed => false)
    haml :opportunity_vetting, :locals => { :opportunity => @op, :receiver => @receiver }
  end

  after '/opportunity/vetting.:id' do
    MessageService.set_to_viewed(@messages_unviewed)
  end

  get '/opportunity/contact.:id' do |id|
    login_required
    @op = Opportunity.first(:id => id)
    author = @op.user
    if author.id == session[:user]
      redirect '/'
    else
      haml :opportunity_contact, :locals => { :title => @op.title, :opportunity => @op }
    end
  end

  post '/opportunity/contact.:id' do |id|
    sender = current_user
    author = User.first(:opportunities => Opportunity.all(:id => id))
    author_id = author.id
    data = {:recipient_id => author_id, :opportunity_id => id, :body => params[:body]}
    clean_data = sanitize_input(data)
    message = MessageService.create(sender, clean_data)
    if message.valid?
      flash[:info] = "Message sent! Opportunity added to 'Contacted'"
      redirect '/'
    else
      flash[:fatal] = message.errors.full_messages.join(", ")
      redirect "/opportunity/contact.#{id}"
    end
  end

  post '/opportunity/send_message.:id' do |id|
    opportunity = Opportunity.first(:id => id)
    sender = current_user
    recipient_id = params[:user_id] || opportunity.user.id
    data = {:recipient_id => recipient_id, :opportunity_id => id, :body => params[:body]}
    clean_data = sanitize_input(data)
    MessageService.create(sender, clean_data)
    if params[:page] == 'conversation'
      redirect "/opportunity/conversation.#{opportunity.id}?user=#{recipient_id}"
    else
      redirect "/opportunity/vetting.#{opportunity.id}?user=#{recipient_id}"
    end
  end

  get '/opportunity/view.:id' do |id|
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
    @op = OpportunityService.update(id, sanitize_input(params[:opportunity]))
    redirect '/'
  end

  get '/opportunity/thanks.:id' do |id|
    login_required
    op = Opportunity.first(:id => id)
    haml :opportunity_thanks, :locals => { :opportunity => op }
  end

  post '/opportunity/thanks.:id' do |id|
    opportunity_id = id
    OpportunityService.thank(session[:user], opportunity_id, sanitize_input(params[:thanks]))
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
    @opportunity = OpportunityService.create(current_user, sanitize_input(params[:opportunity]))
    flash[:info] = "Opportunity created!"
    redirect "/"
  end 

  post '/opportunity/book.:id' do |id|
    @booking = Booking.create!(:opportunity_id => id, :user_id => params[:user])
    user = User.first(:id => params[:user])
    if @booking.valid?
      flash[:info] = "#{user.username} has been booked! Message them here or contact them by email"
      redirect "/opportunity/conversation.#{id}?user=#{params[:user]}"
    else
      flash[:fatal] = @booking.errors_full_messages.join(", ")
      redirect "/opportunity/messages.#{id}"
    end
  end
end
