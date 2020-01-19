class ApplicationController < ActionController::Base
  helper_method :is_bruised_thumb?

  private

  def is_bruised_thumb?
    session[:admin_mode] == true
  end
end
