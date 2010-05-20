require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
 tests UserMailer

  def test_voter_approval
    @user = users(:one)

    # Send the email, then test that it got queued
    email = UserMailer.deliver_voter_approval(@user)
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal [@user.email], email.to
    assert_equal "Welcome to Exist Elections 2010", email.subject
  end
end
