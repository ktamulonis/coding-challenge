require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'creating a post' do 

    it 'has a valid factory' do 
      expect(build(:post)).to be_valid
    end

    it 'must have a title' do
      post = Post.new(title: nil)
      expect(post).to_not be_valid
    end

  end

 
end