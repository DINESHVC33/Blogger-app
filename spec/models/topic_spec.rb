# spec/models/topic_spec.rb
require 'rails_helper'

RSpec.describe Topic, type: :model do
  it "has many posts and depended destroy" do
    association = described_class.reflect_on_association(:posts)
    expect(association.macro).to eq(:has_many)
    expect(association.options[:dependent]).to eq(:destroy)
  end
end
