class ApplicationController < ActionController::Base
  helper_method :is_bruised_thumb?

  private

  def is_bruised_thumb?
    session[:admin_mode] == true
  end

  def require_bruised_thumb
    unless is_bruised_thumb?
      flash[:error] = "You must be logged in to access this section"
      redirect_to log_in_path
    end
  end
end
