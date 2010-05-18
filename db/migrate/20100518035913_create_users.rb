class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :street_number
      t.string :street_name
      t.string :district_code
      t.string :municipality_code
      t.string :provincial_code
      t.string :voter_id
      t.date :birth_date
      t.string :email
      t.boolean :voted
      t.boolean :activated

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
