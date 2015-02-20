require 'rails_helper'

RSpec.describe Api::V1::BuyListsController, :type => :controller do

  describe "GET total_price" do
    it "returns http success" do
      get :total_price
      expect(response).to be_success
    end
  end

end
