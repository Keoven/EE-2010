class ChangeUserDistrictValueFromStringToInteger < ActiveRecord::Migration
  def self.up
    change_column :users, :district_code, :integer
  end

  def self.down
    remove_column :users, :district_code 
  end
end
