require 'rails_helper'

RSpec.describe Api::CoinsController, type: :controller do
  let!(:user) {User.create!(email: "b@b.com", password: "password")}
  let!(:first_coin) { Coin.create!(name: "a", picture: "this.img", user: user) }
  let!(:second_coin) { Coin.create!(name: "b", picture: "this.img", user: user) }

  describe "GET#index" do
    it "should return a list of all the Coins" do

      get :index
      returned_json = JSON.parse(response.body)

      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")
      expect(returned_json.length).to eq 2
      expect(returned_json[0]["name"]).to eq "a"


    end
  end

  describe "GET#show" do
    it "should show a coins show page" do
      get :show, params: {id: first_coin.id}
      returned_json = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(response.content_type).to eq("application/json")

      expect(returned_json["coin"].length).to eq 7
      expect(returned_json["coin"]["name"]).to eq "a"
    end
  end
end
