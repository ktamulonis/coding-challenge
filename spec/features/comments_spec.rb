require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  before do
   Capybara.default_driver = :selenium_chrome
  end

  describe 'viewing comments count link' do

  	it 'displays the number of comments per post'

    it 'links to the post show page'

  end

  describe 'viewing comments collection on post show page' do

  	it 'displays all comments'


  end

  describe 'creating a comment' do 
    it 'has a comments form on post show page'

  end

  describe 'editing a comment' do 
  	it 'has an edit button next to the comment'

  end

  describe 'destroying a comment' do 
  	it 'has a delete button next to the comment'

  end

end