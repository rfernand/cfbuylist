require "rails_helper"

RSpec.describe BoughtCardsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bought_cards").to route_to("bought_cards#index")
    end

    it "routes to #new" do
      expect(:get => "/bought_cards/new").to route_to("bought_cards#new")
    end

    it "routes to #show" do
      expect(:get => "/bought_cards/1").to route_to("bought_cards#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bought_cards/1/edit").to route_to("bought_cards#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bought_cards").to route_to("bought_cards#create")
    end

    it "routes to #update" do
      expect(:put => "/bought_cards/1").to route_to("bought_cards#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bought_cards/1").to route_to("bought_cards#destroy", :id => "1")
    end

  end
end
