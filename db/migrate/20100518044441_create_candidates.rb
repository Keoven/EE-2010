class CreateCandidates < ActiveRecord::Migration
  def self.up
    create_table :candidates do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :position
      t.string :level
      t.string :location
      t.integer :num_votes

      t.timestamps
    end
  end

  def self.down
    drop_table :candidates
  end
end
