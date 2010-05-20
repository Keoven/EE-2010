require 'test_helper'

class Admin::UsersRoutingTest < ActionController::TestCase

  test 'should route to admin users get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admin/users'           } ,
                    { :controller => 'admin/users',
                      :action     => 'index'             } )
  end

  test 'should route to admin users post' do
    assert_routing( { :method     => 'post',
                      :path       => '/admin/users'           } ,
                    { :controller => 'admin/users',
                      :action     => 'create'            } )
  end

  test 'should route to new admin user get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admin/users/new'       } ,
                    { :controller => 'admin/users',
                      :action     => 'new'               } )
  end

  test 'should route to edit admin user get' do
    assert_routing( { :method      => 'get',
                      :path       => '/admin/users/1/edit'    } ,
                    { :controller => 'admin/users',
                      :action     => 'edit',
                      :id         => '1'                 } )
  end

  test 'should route to admin user get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admin/users/1'         } ,
                    { :controller => 'admin/users',
                      :action     => 'show',
                      :id         => '1'                 } )
  end

  test 'should route to admin user put' do
    assert_routing( { :method     => 'put',
                      :path       => '/admin/users/1'         } ,
                    { :controller => 'admin/users',
                      :action     => 'update',
                      :id         => '1'                 } )
  end

  test 'should route to admin user delete' do
    assert_routing( { :method     => 'delete',
                      :path       => '/admin/users/1'         } ,
                    { :controller => 'admin/users',
                      :action     => 'destroy',
                      :id         => '1'                 } )
  end
end

