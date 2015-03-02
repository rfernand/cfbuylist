require 'rails_helper'

RSpec.describe "bought_cards/index", :type => :view do
  before(:each) do
    assign(:bought_cards, [
      BoughtCard.create!(
        :card => nil,
        :usd_price => "9.99",
        :user => nil,
        :condition => "Condition",
        :quantity => 1,
        :bought_list => nil
      ),
      BoughtCard.create!(
        :card => nil,
        :usd_price => "9.99",
        :user => nil,
        :condition => "Condition",
        :quantity => 1,
        :bought_list => nil
      )
    ])
  end

  it "renders a list of bought_cards" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Condition".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
