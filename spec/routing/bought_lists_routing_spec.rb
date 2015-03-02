require "rails_helper"

RSpec.describe BoughtListsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bought_lists").to route_to("bought_lists#index")
    end

    it "routes to #new" do
      expect(:get => "/bought_lists/new").to route_to("bought_lists#new")
    end

    it "routes to #show" do
      expect(:get => "/bought_lists/1").to route_to("bought_lists#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bought_lists/1/edit").to route_to("bought_lists#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bought_lists").to route_to("bought_lists#create")
    end

    it "routes to #update" do
      expect(:put => "/bought_lists/1").to route_to("bought_lists#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bought_lists/1").to route_to("bought_lists#destroy", :id => "1")
    end

  end
end
