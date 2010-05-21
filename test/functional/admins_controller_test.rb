require 'test_helper'
require 'authlogic/test_case'

class AdminsControllerTest < ActionController::TestCase
  setup :activate_authlogic

  ACTIONS = [:new, :edit, :show, :update, :index, :create, :dashboard]

  def teardown
    Admin.delete_all
  end

  test 'should redirect viewer to login page' do
    ACTIONS.each do |action|
      get action, :id => 1
      assert_redirected_to login_path
    end
  end

  test 'should not redirect admin to login page' do
    AdminSession.create(admins(:super))
    ACTIONS.each do |action|
      get action, :id => 1
      assert_response :success
    end
  end

  test 'should succeed in creating new admin' do
    assert_difference('Admin.count') do
      AdminSession.create(admins(:super))
      post :create, :admin => { :login                 => 'three'             ,
                                :email                 => 'three@here.com'    ,
                                :password              => 'three'             ,
                                :password_confirmation => 'three'             }
      assert_equal 'Account registered!', flash[:notice]
    end
  end

  test 'should fail in creating new admin' do
    AdminSession.create(admins(:super))
    post :create, :admin => { :login                 => 'three'             ,
                              :email                 => 'three@here.com'    ,
                              :password              => 'three'             ,
                              :password_confirmation => 'wrong'             }
    assert_response :success
    assert_nil flash[:notice]
  end

  test 'should update admin account with no password' do
    record = admins(:one)
    AdminSession.create(record)
    
    put :update, :id => record.id, :admin => { 	:email => 'thisis@new.com' }
     assert_redirected_to admin_path(record.reload)
     assert_equal 'Account updated!', flash[:notice]
     assert_equal 'thisis@new.com', record.email
    
    #TODO this
    put :update, :id => record.id, :admin => { 	:email => 'Thisis' }
     assert_response :success                     			
  end
  
  test 'should update admin account with passwrd' do
    record = admins(:one)
    AdminSession.create(record)
    
    temp_attr = { :email                 => 'three@here.com'    ,
            	  :password              => 'three'             ,
            	  :password_confirmation => 'three'             }

    put :update, :id => record.id, :admin => temp_attr
     assert_redirected_to admin_path(record.reload)
     assert_equal 'Account updated!', flash[:notice]
     assert_equal 'three@here.com', record.email
    
    put :update, :id => record.id, :admin => temp_attr.merge(:email => 'three')
     assert_response :success 
  end

  test 'should delete admin account' do
    sudo = admins(:super)
    AdminSession.create(sudo)
    if sudo.super_admin?
      assert_difference('Admin.count', -1) do
        delete :destroy, :id => admins(:one).id
        assert_redirected_to dashboard_admins_path
        assert_equal 'Account deleted!', flash[:notice]
      end
    end	
  end
end

