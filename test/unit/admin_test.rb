require 'test_helper'

class AdminTest < ActiveSupport::TestCase

  def setup
    @valid_user1 = admins(:one)
    @valid_user2 = admins(:two)
    @valid_user = Admin.new(:login                 => 'three',
                            :email                 => 'three@email.com',
                            :password              => 'asdf1234',
                            :password_confirmation => 'asdf1234')
  end

  def teardown
    Admin.delete_all
  end

  ## COLUMNS
  #
  test 'should check column value types' do
    assert @valid_user1.login.is_a?(String)
    assert @valid_user1.email.is_a?(String)
    assert @valid_user1.crypted_password.is_a?(String)
    assert @valid_user1.password_salt.is_a?(String)
    assert @valid_user1.persistence_token.is_a?(String)
    assert @valid_user1.single_access_token.is_a?(String)
    assert @valid_user1.perishable_token.is_a?(String)
    assert @valid_user.save
  end

  ## VALIDATIONS
  #
  test 'should validate login' do
    assert_equal true, @valid_user.valid?
    @valid_user.login = ''
    assert_equal false, @valid_user.valid?
    @valid_user.login = 'one'
    assert_equal false, @valid_user.valid?
  end

  test 'should validate email' do
    assert_equal true, @valid_user.valid?
    @valid_user.email = ''
    assert_equal false, @valid_user.valid?
    @valid_user.email = 'one@email.com'
    assert_equal false, @valid_user.valid?
  end

  test 'should validate password' do
    assert_equal true, @valid_user.valid?
    @valid_user.password = ''
    @valid_user.password_confirmation = ''
    assert_equal false, @valid_user.valid?
  end
end

