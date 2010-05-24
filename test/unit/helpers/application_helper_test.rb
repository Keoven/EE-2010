require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "must generate random code" do
    (1..100).each do |i|
      str = generate_code
      assert str.is_a?(String)
      assert str.length == 12
    end
  end
  test "check for valid email" do
    assert_equal true, valid_email("amboysuarez@yahoo.com")
    assert_nil valid_email(admins(:one).email) #admin email already exist
    assert_nil valid_email("asdf") #wrong format
  end
  
  test "formatting" do
    user = users(:one)
    assert_equal "MyString M. MyString", format_name(user)
    assert_equal "1 MyString, <span class=\"address_code\" title=\"QZN\">Quezon City</span>, <span class=\"address_code\" title=\"MML\">Metro Manila</span><span class=\"address_code\" title=\"QZN1\">(1st District)</span>", format_address(user.complete_address)
  end
    
end
