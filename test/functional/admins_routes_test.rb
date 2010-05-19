require 'test_helper'

class AdminsRoutingTest < ActionController::TestCase
  test 'should route to dashboard admins get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admins/dashboard' } ,
                    { :controller => 'admins',
                      :action     => 'dashboard'         } )
  end

  test 'should route to admins get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admins'           } ,
                    { :controller => 'admins',
                      :action     => 'index'             } )
  end

  test 'should route to admins post' do
    assert_routing( { :method     => 'post',
                      :path       => '/admins'           } ,
                    { :controller => 'admins',
                      :action     => 'create'            } )
  end

  test 'should route to new admin get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admins/new'       } ,
                    { :controller => 'admins',
                      :action     => 'new'               } )
  end

  test 'should route to edit admin get' do
    assert_routing( { :method      => 'get',
                      :path       => '/admins/1/edit'    } ,
                    { :controller => 'admins',
                      :action     => 'edit',
                      :id         => '1'                 } )
  end

  test 'should route to admin get' do
    assert_routing( { :method     => 'get',
                      :path       => '/admins/1'         } ,
                    { :controller => 'admins',
                      :action     => 'show',
                      :id         => '1'                 } )
  end

  test 'should route to admin put' do
    assert_routing( { :method     => 'put',
                      :path       => '/admins/1'         } ,
                    { :controller => 'admins',
                      :action     => 'update',
                      :id         => '1'                 } )
  end

  test 'should route to admin delete' do
    assert_routing( { :method     => 'delete',
                      :path       => '/admins/1'         } ,
                    { :controller => 'admins',
                      :action     => 'destroy',
                      :id         => '1'                 } )
  end
end

