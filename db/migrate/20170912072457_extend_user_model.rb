class ExtendUserModel < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_users, :profile, :jsonb
  end
end
