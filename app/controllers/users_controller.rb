class UsersController < ApplicationController
  before_filter :require_election_open, :only => [:home]

  def home
  end

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
<<<<<<< HEAD
      p @user.inspect
      p "################################"
    if @user.update_attributes(params[:user])
      p "Asdf"
      redirect_to @user
    else
      p @user.inspect
      p "qwer"
      render :action=> :edit
=======
    if @user.update_attributes(params[:user])
      redirect_to @user
    else
      render :action=> :edit 
>>>>>>> 129fdc5d2b119e3acf2471cf8afd3d629491d86c
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

