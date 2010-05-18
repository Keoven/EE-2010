class UpdateColumnsOnCandidates < ActiveRecord::Migration
  def self.up
    remove_column :candidates, :location

    add_column :candidates, :province, :string
    add_column :candidates, :municipality, :string
    add_column :candidates, :district, :string
  end

  def self.down
    add_column :candidates, :location, :string

    remove_column :candidates, :province
    remove_column :candidates, :municipality
    remove_column :candidates, :district
  end
end
