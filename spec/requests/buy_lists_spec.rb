require 'rails_helper'

RSpec.describe "BuyLists", :type => :request do
  describe "GET /buy_lists" do
    it "works! (now write some real specs)" do
      get buy_lists_path
      expect(response.status).to be(200)
    end
  end
end
