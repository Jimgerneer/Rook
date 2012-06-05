class Rook < Sinatra::Base
  helpers do
    def login_required
      return true if logged_in?

      session[:return_to] = request.fullpath
      redirect "/login"
      pass rescue throw :pass
    end

    def admin_required
      return true if login_required && current_user.accout_type == 'admin'
      redirect '/'
    end

    def current_user
      Rook::User.get(session[:user])
    end

    def logged_in?
      ! session[:user].nil?
    end

    def redirect_to_stored
      if return_to = session[:return_to]
        session[:return_to] = nil
        redirect return_to
      else
        redirect '/'
      end
    end
  end
end
