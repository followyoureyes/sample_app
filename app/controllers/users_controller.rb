class UsersController < ApplicationController
  before_filter :authenticate,  :only => [:index, :edit, :update, :destroy]
  before_filter :correct_user,  :only => [:edit, :update]
  before_filter :admin_user,    :only => :destroy
  
  def show
    @user = User.find(params[:id])
    @title = @user.name
  end
  
  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def new
    @user = User.new
    @title = "Sign up"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      @title = "Sign up"
      render 'new'
    end
  end
  
  def edit
    @title = "Edit user"
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "profile updated!"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end
  
  def destroy
    user = User.find(params[:id])
    if user.admin?
      redirect_to users_path
      flash[:error] = "Can't delete admin"
    else
    user.destroy
    flash[:success] = "User deleted"
    redirect_to users_path
    end
  end
  
  
  private
    
    def authenticate
      deny_access unless logged_in?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end  
    
    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
