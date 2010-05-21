require 'test_helper'

class PendingBallotTest < ActiveSupport::TestCase
  test 'ballot should belong to a voter' do
    assert_response_to :voter
  end
end

