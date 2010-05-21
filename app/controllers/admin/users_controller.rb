class Admin::UsersController < ApplicationController
 

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
  
  def list_municipalities
    municipality_list = MUNICIPALITY_LIST[params[:province]].sort
    
    render :update do |page|
      page.replace_html :municipality_code_field, :partial => 'municipality_list', :locals => { :list => municipality_list }
      page.replace_html :district_code_field, ""
    end
  end
  
  def list_districts
    district_code = "#{params[:province]}#{params[:municipality]}"
    district_count = DISTRICT_LIST[district_code] || 1
    district_list = {}

    case district_count
      when 1
        district_list["Lone District"] = 1
      else
        district_list = {}
        1.upto district_count do |i|
          district_list["#{i.ordinalize} District"] = "#{district_code}#{i}"
        end
    end
    
    render :update do |page|
      page.replace_html :district_code_field, :partial => 'district_list', :locals => { :list => district_list }
    end
  end
  
end

