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

  get "/signup" do
   haml :signup
  end

  post "/signup" do
    signup
  end

  def login
    if user = Rook::User.authenticate(params[:username], params[:password])
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
     @user = Rook::User.new(params[:user])
     if @user.save
       session[:user] = @user.id
       redirect "/"
     else
       puts @user.errors.full_messages
       redirect "/signup"
    end
  end
end
