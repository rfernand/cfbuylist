require 'rails_helper'

RSpec.describe "bought_cards/new", :type => :view do
  before(:each) do
    assign(:bought_card, BoughtCard.new(
      :card => nil,
      :usd_price => "9.99",
      :user => nil,
      :condition => "MyString",
      :quantity => 1,
      :bought_list => nil
    ))
  end

  it "renders new bought_card form" do
    render

    assert_select "form[action=?][method=?]", bought_cards_path, "post" do

      assert_select "input#bought_card_card_id[name=?]", "bought_card[card_id]"

      assert_select "input#bought_card_usd_price[name=?]", "bought_card[usd_price]"

      assert_select "input#bought_card_user_id[name=?]", "bought_card[user_id]"

      assert_select "input#bought_card_condition[name=?]", "bought_card[condition]"

      assert_select "input#bought_card_quantity[name=?]", "bought_card[quantity]"

      assert_select "input#bought_card_bought_list_id[name=?]", "bought_card[bought_list_id]"
    end
  end
end
