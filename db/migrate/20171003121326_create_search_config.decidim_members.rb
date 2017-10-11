# This migration comes from decidim_members (originally 20171003112400)
# PostgreSQL search config creation
#
# this sets up a config based on PostgreSQL's stock 'english' configuration and
# changes it so any accented characters in queries and documents are converted to
# their non-accented ASCII counterparts.
#
# You might want to change this if your Redmine installation has non-english
# content. See
# http://www.postgresql.org/docs/current/static/textsearch-configuration.html
# for more information.
class CreateSearchConfig < ActiveRecord::Migration[5.1]
  def up
    enable_extension 'unaccent'
    language = 'english'
    execute <<-SQL
      CREATE TEXT SEARCH DICTIONARY #{language}_stem ( TEMPLATE = snowball, Language = #{language}, StopWords = #{language} );
      CREATE TEXT SEARCH CONFIGURATION fundaction (COPY = '#{language}');
      ALTER TEXT SEARCH CONFIGURATION fundaction ALTER MAPPING FOR hword, hword_part, word with unaccent, #{language}_stem;
    SQL
  end

  def down
    execute "drop text search configuation fundaction"
  end
end

