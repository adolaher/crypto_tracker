require 'rails_helper'
include AuthenticationHelper

xfeature "visitor adds rating" do
  #helper file needed
  let(:adam) { FactoryBot.create(:user) }
  let(:hermione) { FactoryBot.create(:user) }
  before(:each) do
    sign_in(adam)
  end
  scenario "successfully adds rating" do
    r1 = Coin.create!(name: "BTC", picture: "img.img", user: adam)
    comment1 = Comment.create!(title: "Supreme", rating: "4", user: hermione)
    visit coin_path(r1)

    fill_in "Title", with: "Lost my money"
    fill_in "Description", with: "Interesting coin"
    fill_in "Rating", with: "2"

    click_button "Add Comment"

    expect(page).to have_content "Comment added successfully"
    expect(page).to have_content r1.name
    expect(page).to have_content "Average Stability Score: 3"

  end

  scenario "visitor inputs invalid rating" do
    visit coin_path(r1)

    fill_in "Rating", with: "A"

    click_button "Add Comment"

    expect(page).to have_content "Rating is not a number"
  end

end
