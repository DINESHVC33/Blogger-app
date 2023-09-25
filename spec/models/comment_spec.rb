require 'rails_helper'

RSpec.describe Comment, type: :model do
  it{should belong_to(:post).dependent(:destroy)}
  it{should have_one(:topic).through(:post)}
end
