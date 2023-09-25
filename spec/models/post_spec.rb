require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "check associations and dependent destroy" do
    it "belongs to topic" do
      check = described_class.reflect_on_association(:topic)
      expect(check.macro).to eq(:belongs_to)
    end

    it "has many comments with dependent destroy" do
      association = described_class.reflect_on_association(:comments)
      expect(association.macro).to eq(:has_many)
      expect(association.options[:dependent]).to eq(:destroy)
    end

    it "has many tags" do
      check = described_class.reflect_on_association(:tags)
      expect(check.macro).to eq(:has_many)
    end

    it "has many post tags" do
      check = described_class.reflect_on_association(:post_tags)
      expect(check.macro).to eq(:has_many)
    end

    it "has many ratings" do
      check = described_class.reflect_on_association(:ratings)
      expect(check.macro).to eq(:has_many)
    end

    it "has one attached image" do
      association = described_class.reflect_on_association(:image_attachment)
      expect(association.macro).to eq(:has_one)
      expect(association.options[:dependent]).to eq(:destroy)
    end
  end
end


require 'rails_helper'

RSpec.describe Post, type: :model do
  it { should belong_to(:topic) }
  it { should have_many(:comments).dependent(:destroy) }
  it { should have_many(:post_tags) }
  it { should have_many(:tags).through(:post_tags) }
  it { should have_many(:ratings).dependent(:destroy) }
  it { should have_one_attached(:image) }

  it "sets the default per-page pagination value to 3" do
    expect(Post.default_per_page).to eq(3)
  end
end

