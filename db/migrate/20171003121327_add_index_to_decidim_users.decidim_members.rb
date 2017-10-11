# This migration comes from decidim_members (originally 20171003112500)
class AddIndexToDecidimUsers < ActiveRecord::Migration[5.1]
  def up
    execute 'ALTER TABLE decidim_users ADD COLUMN tsv TSVECTOR'
    execute 'CREATE INDEX decidim_users_tsv_idx ON decidim_users USING GIN(tsv)'
  end

  def down
    remove_column :decidim_users, :tsv
  end
end
