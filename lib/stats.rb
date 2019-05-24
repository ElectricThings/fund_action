require 'csv'

class Stats
  def initialize
    @users = Decidim::User.order(created_at: :asc).to_a.select{|u|u.email.present?}
    @processes = Decidim::ParticipatoryProcess.all.order(created_at: :asc).to_a

    @headers = ["Email"]
    @processes.each do |p|
      @headers << "Votes (#{p.title['en']})"
    end
    @headers << "Comments"
  end


  def call
    CSV.generate(col_sep: ';', encoding: 'UTF-8') do |csv|
      csv << @headers
      @users.each do |user|
        csv << user_row(user)
      end
    end
  end

  def user_row(user)
    row = [user.email]
    @processes.each do |p|
      votes = Decidim::Proposals::ProposalVote
        .includes(proposal: :component)
        .where(author: user,
               decidim_components: {
                 participatory_space_id: p.id,
                 participatory_space_type: "Decidim::ParticipatoryProcess"
               })
        .count
      row << votes
    end

    comments = Decidim::Comments::Comment.where(author: user).count
    row << comments

    row
  end

  def self.call(filename = 'stats.csv')
    (File.open(filename, "wb") << new.call).close
  end
end
