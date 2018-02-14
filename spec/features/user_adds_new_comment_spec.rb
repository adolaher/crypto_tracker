require 'rails_helper'
include AuthenticationHelper

feature "user adds comments for coins" do

  let(:adam) { FactoryBot.create(:user) }
  before(:each) do
    sign_in(adam)
  end
  scenario "successfully adds a comment" do
    r1 = Coin.create!(name: "BTC", picture: "img.img", user: adam)
    visit coin_path(r1)


    click_link "Add Comment"

    expect(page).to have_content "Comment for BTC"

    fill_in "Title", with: "test title"
    fill_in "Description", with: "test description"
    fill_in "Rating", with: "5"
    fill_in "Please enter date of initial coin investment (yyyy-mm-dd)", with: "2016-10-10"
    fill_in "Please enter the amount of coins invested", with: "1"

    click_button "Add Comment"

    expect(page).to have_content "Comment added successfully"
    expect(page).to have_content r1.name
    expect(page).to have_content "test description"
  end

  scenario "adds a comment for a coin unsuccessfully" do
    r1 = Coin.create!(name: "BTC", picture: "img.img", user: adam)
    visit coin_path(r1)

    click_link "Add Comment"

    expect(page).to have_content "Comment for BTC"

    click_button "Add Comment"

    expect(page).to have_content "Rating can't be blank"
    expect(page).to have_content "Title can't be blank"
  end
end
