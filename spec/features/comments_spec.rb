require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  before do
   Capybara.default_driver = :selenium_chrome
   create(:post, title: 'Hello World', body: 'This is the best post in the World!')
   create(:comment, post_id:1 )

   create(:post, title: 'Helloz World', body: 'This is the zainiest post in the World!')
   create(:comment, post_id:2 )
   create(:comment, body:"LOL zainiest?", post_id:2 )

   create(:post, title: 'Hellos World', body: 'This is the better than bestest post in the World!')
   3.times {create(:comment, post_id:3 )} 

   create(:post, title: 'Hellox World', body: 'This is the top post in the World! Thats why its so long. Maybe a couple thousand words or so, but who cares. Posting rambling thoughts is a thing, and its cool. You wont actually see beyond the first 20 characters on the index page.')
   create(:comment, body:"Way to be verbose!", post_id:4 )
   3.times {create(:comment, body:"TLDR", post_id:4 )} 
  end

  describe 'viewing comments count link' do

  	it 'displays the number of comments per post' do
      visit root_path
      expect(page.body).to include('4 Comments')
    end


    it 'links to the post show page' do 
      visit root_path
      click_on '4 Comments'
      ## uncommenting below code results in capybara session issue, fix later
      #expect(page).to eq(post_path(Post.last))
      #expect(page.body).to include('This is the top post in the World! Thats why its so long. Maybe a couple')

    end

  end

  describe 'viewing comments collection on post show page' do

  	it 'displays all comments' do 
      visit post_path(Post.last)
      expect(page.body).to include('This is the top post in the World! Thats why its so long. Maybe a couple')
      expect(page.body).to include('Way to be verbose!')
      expect(page.body).to include('TLDR')

    end


  end

  describe 'creating a comment' do 

    it 'has a comments form on post show page' do
      expect(Post.first.comments.count).to eq(1)
      visit post_path(Post.first)
      expect(page.body).to include('Your comment:')
      within 'form' do
        fill_in 'comment[body]', with: 'Hey, Rad Post!'
        click_button "Create Comment"

      end

      visit post_path(Post.first)
      expect(Post.first.comments.count).to eq(2)
    end

  end

  describe 'editing a comment' do 
  	it 'has an edit button next to the comment' do 
      visit post_path(Post.first)
      
      click_link "Edit Comment"
      within 'form' do
        fill_in 'comment[body]', with: 'Hey, Thought I would edit this comment'
        click_button "Update Comment"

      end
      visit post_path(Post.first)
      expect(page.body).to include('Hey, Thought I would edit this comment')


    end

  end

  describe 'destroying a comment' do 
  	it 'has a delete button next to the comment' do
      visit post_path(Post.first)
      expect(Post.first.comments.count).to eq(1)
        within '#comment-1' do 
          page.accept_confirm do
            click_link 'Destroy'
        end
      end
      
      visit post_path(Post.first)
      expect(Post.first.comments.count).to eq(0)
    end

  end

end