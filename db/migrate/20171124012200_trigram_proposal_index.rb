
class TrigramProposalIndex < ActiveRecord::Migration[5.0]
  def up
    enable_extension 'pg_trgm'
    execute 'drop index decidim_proposals_proposal_body_search;'
    execute 'CREATE INDEX decidim_proposals_proposal_body_search ON decidim_proposals_proposals USING gist (body gist_trgm_ops);'
  end

end
