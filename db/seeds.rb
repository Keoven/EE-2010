require 'active_record/fixtures'

Admin.create(:id                    => 1                   ,
             :login                 => 'admin'             ,
             :email                 => 'youremail@here.com',
             :password              => 'minda'             ,
             :password_confirmation => 'minda'             )

Fixtures.create_fixtures("#{Rails.root}/config/data","candidates")