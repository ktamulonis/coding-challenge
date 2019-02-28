require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  before do
   Capybara.default_driver = :selenium_chrome
   create(:post, title: 'Hello World', body: 'This is the best post in the World!')
   create(:post, title: 'Helloz World', body: 'This is the bestest post in the World!')
   create(:post, title: 'Hellos World', body: 'This is the better than bestest post in the World!')
   create(:post, title: 'Hellox World', body: 'This is the top post in the World!')
  end

  describe 'viewing all posts' do 

    it 'directs all visitors to site to posts path' do 
      visit root_path
      expect( page.body ).to include('Hello World')
    end

  	it 'lists all posts' do
  	  visit posts_path
  	  expect( page.body ).to include('Career Plug')
  	  expect( Post.count).to eq(4)
  	  expect( page.body ).to include('Hello World')
  	  expect( page.body ).to include('Helloz World')
  	  expect( page.body ).to include('Hellos World')
  	  expect( page.body ).to include('Hellox World')
  	  click_link 'New Post'

    end

    it 'links to each posts show page' do
      visit posts_path
      click_link 'Hello World'
      # expect( page.body ).to include('This is the best post in the World!')

    end

  end

  describe 'creating a post' do 
  	it 'creates new post from form' do
  	  visit new_post_path
  	  expect( page.body ).to include('New Post')
  	  within 'form' do
          fill_in 'post[title]', with: 'Hey Sup from the Sunshine state!'
          fill_in 'post[body]', with: 'Now on a serious note this post is going to address...'
        end

      click_button "Create Post"
      expect( page.body ).to include('Hey Sup from the Sunshine state!')
      expect( page.body ).to include('Now on a serious note this post is going to address...')
    end

  end

  describe 'deleting a post' do 

    it 'can be deleted from index page' do 
      visit posts_path
      expect( page.body ).to include('Hello World')

      within '#post-card-1' do 
        page.accept_confirm do
          click_link 'Destroy'
        end
      end

      expect( page.body ).to_not include('Hello World')

    end


  	it 'can be deleted from show page'

  end

end

