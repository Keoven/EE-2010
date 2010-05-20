require 'test_helper'

class AdminSessionsRoutingTest < ActionController::TestCase
  test 'should route to login' do
    assert_routing( { :path       => '/admin/login'        } ,
                    { :controller => 'admin_sessions'      ,
                      :action     => 'new'                 } )
  end

  test 'should route to logout' do
    assert_routing( { :path       => '/admin/logout'       } ,
                    { :controller => 'admin_sessions'      ,
                      :action     => 'destroy'             } )
  end

  test 'should route to authenticate login' do
    assert_routing( { :path       => '/admin/authenticate' } ,
                    { :controller => 'admin_sessions'      ,
                      :action     => 'create'              } )
  end
end

