require 'rails_helper'

RSpec.feature "Posts", type: :feature do

  before do
   Capybara.default_driver = :selenium_chrome
   create(:post, title: 'Hello World', body: 'This is the best post in the World!')
   create(:post, title: 'Helloz World', body: 'This is the zainiest post in the World!')
   create(:post, title: 'Hellos World', body: 'This is the better than bestest post in the World!')
   create(:post, title: 'Hellox World', body: 'This is the top post in the World! Thats why its so long. Maybe a couple thousand words or so, but who cares. Posting rambling thoughts is a thing, and its cool. You wont actually see beyond the first 20 characters on the index page.')
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
      #expect( page.body ).to include('This is the best post in the World!')

    end

    it 'show abbreviated body of each Post' do 
      visit posts_path
      expect( page.body ).to include('This is the top post in the...')

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


  	it 'can be deleted from show page' do 
      expect(Post.count).to eq(4)
      expect(Post.last.id).to eq(4)
      visit post_path(Post.last)
      page.accept_confirm do
        click_link 'Destroy'
      end
      visit root_path
      expect(Post.last.id).to eq(3)
      expect(Post.count).to eq(3)

    end

    it 'destroys all related comments' do 

      3.times {create(:comment, post_id:2 )} 
      expect(Comment.count).to eq(3)
      expect(Post.second.comments.count).to eq(3)
      visit root_path

      within '#post-card-2' do 
        page.accept_confirm do
          click_link 'Destroy'
        end
      end

      visit root_path

      expect(Post.second.comments.count).to eq(0)
      expect(Comment.count).to eq(0)

    end

  end

  describe 'search for a specific Post' do

    it 'searches the posts table on title' do 
      visit root_path
      within 'form' do
        fill_in 'term', with: 'Hellox' 
      end

      click_button "Search"

      expect( page.body ).to_not include('Hello World')
      expect( page.body ).to_not include('Helloz World')
      expect( page.body ).to_not include('Hellos World')
      expect( page.body ).to include('Hellox World')


    end

    it 'searches the posts table on body' do  
      visit root_path
      within 'form' do
        fill_in 'term', with: 'zainiest' 
      end

      click_button "Search"

      expect( page.body ).to_not include('Hello World')
      expect( page.body ).to include('Helloz World')
      expect( page.body ).to_not include('Hellos World')
      expect( page.body ).to_not include('Hellox World')

    end


  end

end

