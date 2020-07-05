class SetUsersRegistrationMode < ActiveRecord::Migration[5.2]
  def up
    Decidim::Organization.find_each do |o|
      o.update_column :users_registration_mode, :existing
    end
  end
end
