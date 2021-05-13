class RemoveCustomUserSearch < ActiveRecord::Migration[5.1]
  def up
    remove_column :decidim_users, :tsv
    execute "drop text search configuration fundaction"
  end

  def down
    enable_extension 'unaccent'
    language = 'english'
    execute <<-SQL
      CREATE TEXT SEARCH DICTIONARY #{language}_stem ( TEMPLATE = snowball, Language = #{language}, StopWords = #{language} );
      CREATE TEXT SEARCH CONFIGURATION fundaction (COPY = '#{language}');
      ALTER TEXT SEARCH CONFIGURATION fundaction ALTER MAPPING FOR hword, hword_part, word with unaccent, #{language}_stem;
    SQL

    execute 'ALTER TABLE decidim_users ADD COLUMN tsv TSVECTOR'
    execute 'CREATE INDEX decidim_users_tsv_idx ON decidim_users USING GIN(tsv)'
  end
end
