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
    assert_difference('PendingBallot.all.size') do
      @user = users(:one)
      @param = { :birth_date => @user.birth_date ,
                 :email      => @user.email      ,
                 :voter_id   => @user.voter_id   }
      get :activate, :user => @param
      assert_equal 'User account activated!', flash[:notice]
      assert !ActionMailer::Base.deliveries.empty?
      get :activate, :user => @param
      assert_equal 'User account already activated!', flash[:notice]
    end
  end

  test 'should show ballot' do
    get :ballot, :code => 'asdf1234'
    assert_response :success
    get :ballot, :code => 'Invalid Code'
    assert_redirected_to root_path
  end

  ## TODO:
  #  Finish cast ballot test.

  test 'should cast ballot' do
    assert_difference('PendingBallot.all.size', -1) do
      ballot = { 'President'      =>     [1] ,
                 'Vice President' =>     [2] ,
                 'Senator'        =>  [3, 4] ,
                 'Governor'       =>     [5] ,
                 'Vice Governor'  =>     [6] ,
                 'Mayor'          =>     [7] ,
                 'Vice Mayor'     =>     [8] ,
                 'Councilor'      =>     [9] ,
                 'Representative' =>    [10] }
      put :cast_ballot, :voter_id => 'non_activated_voter', :code => 'asdf1234', :ballot => ballot
      assert_redirected_to root_path
      put :cast_ballot, :voter_id => 'activated_voter', :code => 'asdf1234', :ballot => ballot
      assert_equal 10, Candidate.sum(:num_votes)
      assert_response :success
    end
  end
end

