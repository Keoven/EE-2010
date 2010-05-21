class ChangeDistrictCodeValueTypeToString < ActiveRecord::Migration
  def self.up
    change_column(:users, :district_code, :string)
  end

  def self.down
    change_column(:users, :district_code, :integer)
  end
end
