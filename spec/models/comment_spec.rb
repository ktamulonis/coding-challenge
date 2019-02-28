require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'a comment' do 

    it 'has a valid factory' do 
      expect(build(:comment)).to be_valid
    end

    it 'must have a body' do
      comment = Comment.new(body: nil)
      expect(comment).to_not be_valid
    end

    it 'must have a post' do 
      comment = Comment.new(post: nil)
      expect(comment).to_not be_valid
    end

  end

 
end
