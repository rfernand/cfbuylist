require 'rails_helper'

RSpec.describe "cards/edit", :type => :view do
  before(:each) do
    @card = assign(:card, Card.create!(
      :name => "MyString",
      :price => 1.5,
      :link => "MyString",
      :user_id => 1
    ))
  end

  it "renders the edit card form" do
    render

    assert_select "form[action=?][method=?]", card_path(@card), "post" do

      assert_select "input#card_name[name=?]", "card[name]"

      assert_select "input#card_price[name=?]", "card[price]"

      assert_select "input#card_link[name=?]", "card[link]"

      assert_select "input#card_user_id[name=?]", "card[user_id]"
    end
  end
end
