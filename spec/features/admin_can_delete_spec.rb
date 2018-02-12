require 'rails_helper'
include AuthenticationHelper
feature "admin " do
  let(:adam) { FactoryBot.create(:user, role: "admin") }
  before(:each) do
    sign_in(adam)
  end
  scenario "deletes a coin successfully" do
    r1 = Coin.create!(name: "BTC", picture: "this.img", user: adam)
    visit coin_path(r1)

    click_link "Delete Coin"

    expect(page).not_to have_content "Bitcoin"
  end

  scenario "deletes a comment successfully" do
    r1 = Coin.create!(name: "Bitcoin", picture: "this.img", user: adam)
    review1= Comment.create!(title: "comment for r1", rating: "2", coin_id: r1.id, user_id: adam.id)
    visit coin_path(r1)

    click_link "Delete Comment"

    expect(page).not_to have_content "comment for r1"
  end
end
