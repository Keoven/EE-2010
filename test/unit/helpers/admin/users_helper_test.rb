require 'test_helper'

class Admin::UsersHelperTest < ActionView::TestCase
  def setup
    @valid_user = users(:one)
  end

  def teardown
    User.delete_all
  end
  
  test "this helper method" do
    assert_equal [["Provincial District", "1"]], generate_district_list("","")
    assert generate_district_list(@valid_user.provincial_code, @valid_user.municipality_code)
  end
end
