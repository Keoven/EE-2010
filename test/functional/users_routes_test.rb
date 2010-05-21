require 'test_helper'

class UsersRoutingTest < ActionController::TestCase
  test 'should route to ballot get' do
    assert_routing( { :method     => 'get',
                      :path       => '/ballot'  } ,
                    { :controller => 'users',
                      :action     => 'ballot'         } )
  end

  test 'should route to home get' do
    assert_routing( { :method     => 'get',
                      :path       => '/'  } ,
                    { :controller => 'users',
                      :action     => 'home'         } )
  end

  test 'should route to election closed get' do
    assert_routing( { :method     => 'get',
                      :path       => '/election_closed'  } ,
                    { :controller => 'users',
                      :action     => 'election_closed'   } )
  end

  test 'should route to validate for activation get' do
    assert_routing( { :method     => 'get',
                      :path       => '/activate_for_activation'  } ,
                    { :controller => 'users',
                      :action     => 'activate_for_activation'   } )
  end

  test 'should route to activate put' do
    assert_routing( { :method     => 'put',
                      :path       => '/activate'  } ,
                    { :controller => 'users',
                      :action     => 'activate'   } )
  end

  test 'should route to cast ballot put' do
    assert_routing( { :method     => 'put',
                      :path       => '/cast_ballot'  } ,
                    { :controller => 'users',
                      :action     => 'cast_ballot'   } )
  end
end

