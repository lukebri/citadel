require 'match_seeder/seeder'

class Division < ActiveRecord::Base
  include MatchSeeder

  belongs_to :competition
  has_many :rosters, class_name: 'CompetitionRoster'
  has_many :matches, through: :rosters, source: :home_team_matches, class_name: 'CompetitionMatch'

  validates :competition, presence: true
  validates :name, presence: true, length: { in: 1..64 }

  alias_attribute :to_s, :name

  def approved_rosters
    rosters.where(approved: true)
  end

  def active_rosters
    approved_rosters.where(disbanded: false)
  end
end
