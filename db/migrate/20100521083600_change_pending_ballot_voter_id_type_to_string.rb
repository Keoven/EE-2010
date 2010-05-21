class ChangePendingBallotVoterIdTypeToString < ActiveRecord::Migration
  def self.up
    change_column(:pending_ballots, :voter_id, :string)
  end

  def self.down
    change_column(:pending_ballots, :voter_id, :integer)
  end
end

