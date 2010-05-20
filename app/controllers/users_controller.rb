class UsersController < ApplicationController
  ##Hooks/Callbacks
  #
  before_filter :require_election_open, :only => [:home]
  
  ## Actions
  def home
  end
  
  ##GET /users
  #
  def index
    @users = User.all
  end

  ##POST /users
  #
  def create
    @user = User.new(params[:user])

    if @user.save
      session[:save] = @user.id
      redirect_to admin_user_path(@user) 
    else
      session[:save] = 'Invalid data'
      render :action => :new
    end    
  end
  
  ##GET /users/new
  #
  def new
    @user = User.new
  end
  
  ##GET /users/:id/edit
  #
  def edit
    @user = User.find(params[:id])
  end

  ##GET /users/:id
  #
  def show
    @user = User.find(params[:id])
  end
  
  ##PUT /users/:id
  #
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_user_path(@user)
    else
      render :action=> :edit
    end
  end
  
  ##DELETE /users/:id
  #
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to(users_url)
  end

end

