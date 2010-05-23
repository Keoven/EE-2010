class Admin::UsersController < ApplicationController

  ##GET /admin/users
  #
  def index
    @users = User.paginate :page => params[:page], :per_page => 10, :order => "last_name"
    
    respond_to do |format|
      format.html
      format.js {
        render :update do |page|
          page.replace 'user_records', :partial => 'records'
        end
      }
    end
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
    if @user.update_attributes!(params[:user])
      redirect_to admin_user_path(@user)
    else
      render :action=> :edit
    end
  end

  ##DELETE /admin/users/:id
  #
  def destroy
    User.find(params[:id]).destroy
    redirect_to admin_users_path
  end

  def list_municipalities
    municipality_list = MUNICIPALITY_LIST[params[:province]].sort

    render :update do |page|
      page.replace_html :municipality_code_field, :partial => 'municipality_list', :locals => { :list => municipality_list }
      page.replace_html :district_code_field, :partial => 'district_list',
        :locals => { :list => generate_district_list(params[:province], municipality_list.first[1]) }
    end
  end

  def list_districts
    district_list = generate_district_list(params[:province], params[:municipality])

    render :update do |page|
      page.replace_html :district_code_field, :partial => 'district_list', :locals => { :list => district_list }
    end
  end

  private
  def generate_district_list(province, municipality)
    district_code = "#{province}#{municipality}"
    district_count = DISTRICT_LIST[district_code] || 0
    district_list = {}

    case district_count
      when 0
        district_list["Provincial District"] = "#{province}1"
      when 1
        district_list["Lone District"] = "#{district_code}1"
      else
        district_list = {}
        1.upto district_count do |i|
          district_list["#{i.ordinalize} District"] = "#{district_code}#{i}"
        end
    end
    
    return district_list.sort
  end
end

