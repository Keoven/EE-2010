require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @valid_user1 = users(:one)
    @valid_user2 = users(:two)
    @valid_user = User.create( :id => 1, :first_name => 'a', :middle_name => 'b', :last_name => 'c',
     			       :street_number => 1, :street_name => 'string',
     			       :district_code => 'asdf', :municipality_code => 'asdf', :provincial_code => 'asdf',
     			       :voter_id => 'qwer1234', :birth_date => Date.new, :email => 'a@asdf.com',
     			       :voted => true, :activated => true)
  end

  def teardown
    User.delete_all
  end

  ## Columns
  #
  test "check columns" do
    assert @valid_user.first_name.is_a?(String)
    assert @valid_user.middle_name.is_a?(String)
    assert @valid_user.last_name.is_a?(String)
    assert @valid_user.street_number.is_a?(Integer)
    assert @valid_user.street_name.is_a?(String)
    assert @valid_user.district_code.is_a?(String)
    assert @valid_user.municipality_code.is_a?(String)
    assert @valid_user.provincial_code.is_a?(String)
    assert @valid_user.voter_id.is_a?(String)
    assert @valid_user.birth_date.is_a?(Date)
    assert @valid_user.email.is_a?(String)
    assert @valid_user.voted.is_a?(TrueClass)
    assert @valid_user.activated.is_a?(TrueClass)
    assert @valid_user.save
    p @valid_user.inspect
    #p @valid_user.errors.inspect
  end

  ## validation
  #
  test "validity of name" do
    @valid_user.first_name = nil
    @valid_user.middle_name = nil
    @valid_user.last_name = nil
    assert_equal false, @valid_user.valid?
  end

  test "validity of address" do
    @valid_user.street_number = nil
    @valid_user.street_name = nil
    assert_equal false, @valid_user.valid?
  end

  test "validity of distric_code" do
    @valid_user.district_code = 'AH1N1'
    assert_equal true, @valid_user.save
    @valid_user.district_code = '1234'
    assert_equal true, @valid_user.save
    @valid_user.district_code = nil
    assert_equal false, @valid_user.valid?
  end

  test "validity of municipality_code" do
    @valid_user.municipality_code = 'AH1N1'
    assert_equal true, @valid_user.save
    @valid_user.municipality_code = '1234'
    assert_equal true, @valid_user.save
    @valid_user.municipality_code = nil
    assert_equal false, @valid_user.valid?
  end

  test "validity of provincial_code" do
    @valid_user.provincial_code = 'AH1N1'
    assert_equal true, @valid_user.save
    @valid_user.provincial_code = '1234'
    assert_equal true, @valid_user.save
    @valid_user.provincial_code = nil
    assert_equal false, @valid_user.valid?
  end

  test "validity of email" do
    assert_match /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i , @valid_user.email
  end

end

