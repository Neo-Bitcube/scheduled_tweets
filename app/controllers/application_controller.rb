class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  private

  def authenticate_user!
    redirect_to root_path, alert: "You must be logged in to do that." unless user_signed_in?
  end
  def current_user
    Current.user ||= authenticate_user_from_session
  end
   helper_method :current_user

  def authenticate_user_from_session
    User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    current_user.present?
  end
  helper_method :user_signed_in?
  def require_user_logged_in!
    redirect_to new_session_path, alert: "You must be signed in to do that." if current_user.nil?
  end


  def login(user)
     Current.user = user
     reset_session
     session[:user_id] = user.id
  end

    def logout(user)
      Current.user = nil
      reset_session
    end
end
