class Admin::UsersController < ApplicationController
  ##Hooks/Callbacks
  #
  before_filter :require_election_open, :only => [:home]

  ##GET /admin/users
  #
  def index
    @users = User.all
  end

  ##POST /admin/users
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

  ##GET /admin/users/new
  #
  def new
    @user = User.new
  end

  ##GET /admin/users/:id/edit
  #
  def edit
    @user = User.find(params[:id])
  end

  ##GET /admin/users/:id
  #
  def show
    @user = User.find(params[:id])
  end

  ##PUT /admin/users/:id
  #
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to admin_user_path(@user)
    else
      render :action=> :edit
    end
  end

  ##DELETE /admin/users/:id
  #
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path
  end
end

