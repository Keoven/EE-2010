class CreatePendingBallots < ActiveRecord::Migration
  def self.up
    create_table :pending_ballots do |t|
      t.string :ballot_key
      t.integer :voter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :pending_ballots
  end
end
