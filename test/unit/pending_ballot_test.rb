require 'test_helper'

class PendingBallotTest < ActiveSupport::TestCase
  def setup
    @ballot = PendingBallot.new(:ballot_key => '1234', :voter_id => 'activated_voter')
  end

  def teardown
    PendingBallot.delete_all
  end

  test 'ballot should belong to a voter' do
    assert(pending_ballots(:one).respond_to? :voter)
  end

  ## COLUMNS
  #
  test "check column types" do
    assert @ballot.voter_id.is_a?(String)
    assert @ballot.ballot_key.is_a?(String)
    assert @ballot.save
  end
end

