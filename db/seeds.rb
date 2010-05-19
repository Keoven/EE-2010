<<<<<<< HEAD
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

Admin.create(:id                    => 1                   ,
             :login                 => 'admin'             ,
             :email                 => 'youremail@here.com',
             :password              => 'minda'             ,
             :password_confirmation => 'minda'             )

=======
require 'active_record/fixtures'

Fixtures.create_fixtures("#{Rails.root}/db/migrate/data","candidates")
>>>>>>> d99fd58e1349664ec7f67b56691963a719911478
