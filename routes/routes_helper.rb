module Rookery
  module Helpers

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
      @current_user ||= User.get(session[:user])
    end

#   def logged_in?
#     ! session[:user].nil?
#   end

    def check_for_messages
      @message_unviewed = Message.all(:recipient_id => current_user.id, :viewed => false, :opportunity => Opportunity.all(:active => true))
      if @message_unviewed != []
        flash.now[:warning] = 'You have unread messages'
      end
    end

    def unread_messages?
      messages = Message.all(:recipient_id => current_user.id, :viewed => false)
      if messages == []
        false
      else
        true
      end
    end

    def redirect_to_stored
      if return_to = session[:return_to]
        session[:return_to] = nil
        redirect return_to
      else
        redirect '/'
      end
    end

    def list_skills_acquired(user)
      acquired_skills = []
      user.skills_acquired.each do |skill|
        acquired_skills << skill.name
      end
      acquired_skills.join(", ")
    end

    def list_skills_desired(user)
      desired_skills = []
      user.skills_desired.each do |skill|
        desired_skills << skill.name
      end
      desired_skills.join(", ")
    end

    def formatted_timestamp(object)
      object.created_at
    end

    def sanitize_input(data)
      new_data = { }
      data.each do |k,v|
        case v
        when Fixnum
          new_data[k] = v.to_s
        when String, NilClass
          new_data[k] = Sanitize.clean(v)
        else
          new_data[k] = sanitize_input(v)
        end
      end
      new_data
    end

    alias_method :logged_in?, :current_user
  end
end
