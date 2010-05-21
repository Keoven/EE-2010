require 'test_helper'

class PendingBallotTest < ActiveSupport::TestCase
  test 'ballot should belong to a voter' do
    assert(pending_ballots(:one).respond_to? :voter)
  end
end

