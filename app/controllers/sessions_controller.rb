class SessionsController < ApplicationController
  def new
    @title = "Login"
  end
  
  def create
    user = User.authenticate(params[:session][:email],
                            params[:session][:password])
     if user.nil?
        flash.now[:error] = "You lost sucker! Your email/ password combination is invalid."
        @title = "Log in"
        render 'new'
      else
        log_in user
        redirect_to user
      end
  end
  
  def destroy
    log_out
    redirect_to root_path
  end
end
