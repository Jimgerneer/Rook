require_relative 'routes_helper'
class Rook < Sinatra::Base

  get "/login" do
    haml :login
  end

  post "/login" do
    login
  end

  get "/logout" do
    logout
  end

  get "/user" do
    user_id = session[:user]
    @user_opportunities = Opportunity.all(:user_id => user_id, :active => true)
    user = User.first(:id => user_id)
    @current_username = user.username
    @booked_opportunities = user.booked_opportunities(:active => true)
    haml :user
  end

  get "/signup" do
    #temp code for beta
    redirect "/beta"
   #haml :signup
  end

  get '/beta' do
    haml :beta
  end

  post "/signup" do
    signup(params[:user])
  end

  post "/beta_signup" do
    beta_signup(params[:user])
  end

  get '/beta_welcome' do
    haml :beta_welcome
  end

  def login
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user] = user.id
      redirect_to_stored
    elsif 5 == session[:login_attempts]
      #future reset page
      redirect "/"
    else
      session[:login_attempts] = session[:login_attempts].to_i + 1
      flash[:fatal] = "Incorrect user or password"
      redirect "/login"
    end
  end

  def logout
    session[:user] = nil
    redirect "/"
  end

  def signup(new_user)
     @new_user = UserService.create(new_user)
     if @new_user.valid?
       session[:user] = @new_user.id
       redirect "/user"
     else
       puts @new_user.errors.full_messages
       redirect "/signup"
    end
  end

  def beta_signup(new_user)
    UserService.create(new_user)
    redirect "/beta_welcome"
  end

  def current_user
    @current_user ||= User.first(:id => session[:user])
  end

  alias_method :logged_in?, :current_user
end
