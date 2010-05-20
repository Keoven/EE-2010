require 'test_helper'

class Admin::UsersControllerTest < ActionController::TestCase
  def setup
    @user = User.create(:first_name 		=> 'Alejandro',
			:middle_name 		=> 'Marasigan',
			:last_name 		=> 'Suarez',
			:street_number 		=> 1,
			:street_name 		=> 'string',
			:district_code 		=> 'QZN1',
			:municipality_code 	=> 'QZN',
			:provincial_code   	=> 'MML',
			:voter_id 		=> 'qwer12341234',
			:birth_date 		=> Date.today << 264,
			:email 			=> 'q@asdf.com',
			:voted 			=> true,
			:activated 		=> true)
    #user parameters
    @user1 = {          :first_name 		=> 'Alejandro',
			:middle_name 		=> 'Marasigan',
			:last_name 		=> 'Suarez',
			:street_number 		=> 1,
			:street_name 		=> 'string',
			:district_code 		=> 'QZN1',
			:municipality_code 	=> 'QZN',
			:provincial_code   	=> 'MML',
			:voter_id 		=> 'qwer',
			:birth_date 		=> Date.today << 264,
			:email 			=> 'aaaa@asdf.com',
			:voted 			=> true,
			:activated 		=> true}
    #user parameters but activated = false
    @user2 = {          :first_name 		=> 'Ale',
			:middle_name 		=> 'Ma',
			:last_name 		=> 'Su',
			:street_number 		=> 1,
			:street_name 		=> 'stringify',
			:district_code 		=> 'QZN1',
			:municipality_code 	=> 'QZN',
			:provincial_code   	=> 'MML',
			:voter_id 		=> 'qwer12341234',
			:birth_date 		=> Date.today << 264,
			:email 			=> 'a@asdf.com',
			:voted 			=> true,
			:activated 		=> false}
  end

  def teardown
    User.delete_all
    @user1 = nil
    @user2 = nil
  end

  ## test methods
  #

  test "action index" do
    get :index
    assert_response :success
  end

  test "action create - ok" do
    assert_difference('User.count', +1) do
      post :create, :user => @user1
    end
    assert_redirected_to :controller => "users", :action => "show", :id => session[:save]
  end

  test "action create - fail" do
    assert_no_difference('User.count') do
      post :create, :user => @user2
    end
    assert_response :success
  end

  test "action update" do
    put :update, :id => @user.id, :user => @user1
    assert_redirected_to :controller => "users", :action => "show"
  end

  test "action destroy" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user.id
    end
    assert_redirected_to :controller => "users", :action => "index"
  end
end

