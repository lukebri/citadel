require 'rails_helper'
require 'support/factory_girl'

describe Map do
  before { create(:map) }

  it { should belong_to(:game) }

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_length_of(:name).is_at_least(1) }
  it { should validate_length_of(:name).is_at_most(64) }

  it { should allow_value('').for(:description) }
  it { should validate_length_of(:description).is_at_least(0) }
end
