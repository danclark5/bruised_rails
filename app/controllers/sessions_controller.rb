class SessionsController < ApplicationController
  def new
  end
  def create
    if authenticate(params[:password])
      session[:admin_mode] = true
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:admin_mode] = nil
    redirect_to root_url, :notice => "Logged out!"
  end

  def authenticate(password)
    if ENV["BH_SECRET"] == BCrypt::Engine.hash_secret(password, ENV["BH_SECRET_SALT"])
      true
    else
      nil
    end
  end
end
