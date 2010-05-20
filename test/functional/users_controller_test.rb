require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  ACTIONS = [:home    , :election_closed, :validate_for_activation,
             :activate, :ballot    , :cast_ballot                 ]

  def setup
    APP_CONFIG['election_status'] = 'open'
  end

  test 'should flash notice that election is not open' do
    APP_CONFIG['election_status'] = 'close'
    ACTIONS.each do |action|
      get action
      assert_nil session[:action_accessed?]
    end
    APP_CONFIG['election_status'] = 'open'
    ACTIONS.each do |action|
      get action
      assert session[:action_accessed?]
    end
  end

  test 'should validate for activation' do
    @user = users(:one)
    get :validate_for_activation, :conditions => { :birth_date => @user.birth_date ,
                                                   :email      => @user.email      ,
                                                   :voter_id   => @user.voter_id   }
    assert_equal 'Voter exists!', flash[:notice]
    get :validate_for_activation, :conditions => { :birth_date => @user.birth_date ,
                                                   :email      => @user.email      ,
                                                   :voter_id   => 'Invalid ID'     }
    assert_equal 'User not found!', flash[:notice]
  end

  test 'should activate account' do
    @user = users(:one)
    @param = { :birth_date => @user.birth_date ,
               :email      => @user.email      ,
               :voter_id   => @user.voter_id   }
    get :activate, :user => @param
    assert_equal 'User account activated!', flash[:notice]
    get :activate, :user => @param
    assert_equal 'User account already activated!', flash[:notice]
  end

  test 'should show ballot' do
    get :ballot, :code => 'asdf1234'
    assert_response :success
    get :ballot, :code => 'Invalid Code'
    assert_redirected_to home_users_path
  end

  ## TODO:
  #  Finish cast ballot test.

  test 'should cast ballot' do
    put :cast_ballot, :voter_id => 1234, :ballot => { :president      =>     [1] ,
                                                      :vice_president =>     [2] ,
                                                      :senator        =>  [3, 4] ,
                                                      :governor       =>     [5] ,
                                                      :vice_governor  =>     [6] ,
                                                      :mayor          =>     [7] ,
                                                      :vice_mayor     =>     [8] ,
                                                      :councilor      =>     [9] ,
                                                      :representative =>    [10] }

  end
end

