class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.isActivated?
      if @user.save
        session[:save] = @user.id
        redirect_to @user 
      else
        session[:save] = 'Invalid User'
        render :action => :new
      end    
    else
      session[:save] = 'Account not yet activated'
      render :action => :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :action=> :edit 
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end

  def show
    @user = User.find(params[:id])
  end

end
