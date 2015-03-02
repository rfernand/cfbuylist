require 'rails_helper'

RSpec.describe "BoughtCards", :type => :request do
  describe "GET /bought_cards" do
    it "works! (now write some real specs)" do
      get bought_cards_path
      expect(response.status).to be(200)
    end
  end
end
