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
    @user_opportunities = Opportunity.all(:user_id => user_id)
    @current_username = User.first(:id => user_id).username
    haml :user
  end

  get "/signup" do
   haml :signup
  end

  post "/signup" do
    signup
  end

  def login
    if user = User.authenticate(params[:username], params[:password])
      session[:user] = user.id
      redirect_to_stored
    else
      redirect "/login"
    end
  end

  def logout
    session[:user] = nil
    redirect "/"
  end

  def signup
     @user = User.new(params[:user])
     if @user.save
       session[:user] = @user.id
       redirect "/user"
     else
       puts @user.errors.full_messages
       redirect "/signup"
    end
  end
end
