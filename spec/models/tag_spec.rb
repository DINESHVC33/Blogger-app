require 'rails_helper'

RSpec.describe Tag, type: :model do
  it{should have_many(:post_tags)}
  it {should have_many(:posts).through(:post_tags)}
end
