require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  ##Setup and Teardown
  #
  def setup
    @valid_admin1 = admins(:one)
    @valid_admin2 = admins(:two)
    @valid_admin = Admin.new(:login                 => 'three',
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
    assert @valid_admin1.login.is_a?(String)
    assert @valid_admin1.email.is_a?(String)
    assert @valid_admin1.crypted_password.is_a?(String)
    assert @valid_admin1.password_salt.is_a?(String)
    assert @valid_admin1.persistence_token.is_a?(String)
    assert @valid_admin1.single_access_token.is_a?(String)
    assert @valid_admin1.perishable_token.is_a?(String)
    assert @valid_admin.save
  end

  ## VALIDATIONS
  #
  test 'should validate login' do
    assert_equal true, @valid_admin.valid?
    @valid_admin.login = ''
    assert_equal false, @valid_admin.valid?
    @valid_admin.login = 'one'
    assert_equal false, @valid_admin.valid?
  end

  test 'should validate email' do
    assert_equal true, @valid_admin.valid?
    @valid_admin.email = ''
    assert_equal false, @valid_admin.valid?
    @valid_admin.email = 'one@email.com'
    assert_equal false, @valid_admin.valid?
  end

  test 'should validate password' do
    assert_equal true, @valid_admin.valid?
    @valid_admin.password = ''
    @valid_admin.password_confirmation = ''
    assert_equal false, @valid_admin.valid?
  end
end

