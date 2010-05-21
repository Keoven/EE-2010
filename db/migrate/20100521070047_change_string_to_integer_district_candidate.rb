class ChangeStringToIntegerDistrictCandidate < ActiveRecord::Migration
  def self.up
    change_column(:candidates, :district, :integer)
  end

  def self.down
    change_column(:candidates, :district, :string)
  end
end

