class SessionsController < ApplicationController
  def home
  end
  
  def new
    redirect_to user_path(session[:user_id]), :notice => 'Already Logged in!' unless anonymous_user?
  end
  
  def create    
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to user_path(session[:user_id])
    else
      redirect_to login_path, notice: 'Invalid email or password'
    end
  end
  
  def destroy
    @user = nil
    session[:user_id] = nil
    redirect_to home_path, notice: 'Logout successful'
  end
end
