require 'rails_helper'
include AuthenticationHelper

feature "admin " do
  let(:adam) { FactoryBot.create(:user, role: "admin") }
  before(:each) do
    sign_in(adam)
  end

  scenario "can successfully edit a comment" do
    r1 = Coin.create!(name: "BTC", picture: "this.img", user: adam)
    comment1= Comment.create!(title: "comment for r1", rating: "2", coin_id: r1.id, user_id: adam.id)

    visit coin_path(r1)

    click_link "Edit Comment"

    fill_in "Title", with: "test title"
    fill_in "Description", with: "test description"
    fill_in "Rating", with: "5"


    click_button "Add Comment"

    expect(page).to have_content "test description"
  end

  scenario "can successfully edit a coin" do
    r1 = Coin.create!(name: "bitcoin", picture: "img.img", user: adam)
    comment1= Comment.create!(title: "comment for r1", rating: "2", coin_id: r1.id, user_id: adam.id)

    visit coin_path(r1)

    click_link "Edit Coin"

    fill_in "Name", with: "Bitcoin again"
    fill_in "Picture", with: "img.img"
    fill_in "Description", with: "Test Description"

    click_button "Add Coin"

    expect(page).to have_content "Bitcoin again"
    expect(page).to have_content "Test Description"
  end



end
