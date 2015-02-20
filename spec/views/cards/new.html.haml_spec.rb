require 'rails_helper'

RSpec.describe "cards/new", :type => :view do
  before(:each) do
    assign(:card, Card.new(
      :name => "MyString",
      :price => 1.5,
      :link => "MyString",
      :user_id => 1
    ))
  end

  it "renders new card form" do
    render

    assert_select "form[action=?][method=?]", cards_path, "post" do

      assert_select "input#card_name[name=?]", "card[name]"

      assert_select "input#card_price[name=?]", "card[price]"

      assert_select "input#card_link[name=?]", "card[link]"

      assert_select "input#card_user_id[name=?]", "card[user_id]"
    end
  end
end
