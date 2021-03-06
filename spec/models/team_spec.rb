require 'rails_helper'
require 'support/shoulda'
require 'support/factory_girl'

describe Team do
  let!(:team) { create(:team) }

  it { should have_many(:team_invites) }
  it { should have_many(:transfers) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }
  it { should validate_length_of(:name).is_at_most(64) }

  it { should allow_value('').for(:description) }
  it { should validate_length_of(:description).is_at_least(0) }

  describe 'players' do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:user3) { create(:user) }

    it 'works for multiple users with multiple adds and removes' do
      team.add_player!(user1)
      team.add_player!(user2)
      team.add_player!(user3)
      team.remove_player!(user2)
      team.remove_player!(user3)
      team.add_player!(user2)

      expect(team.transfers.size).to eq(6)
      expect(team.player_users).to eq([user1, user2])
    end
  end

  describe '#destroy' do
    it "can't be destroyed when the team has roster" do
      create(:competition_roster, team: team)

      expect(team.destroy).to eq(false)
    end

    it 'can be destroyed' do
      expect(team.destroy).to_not be(nil)
    end
  end
end
