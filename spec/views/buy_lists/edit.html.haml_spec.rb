require 'rails_helper'

RSpec.describe "buy_lists/edit", :type => :view do
  before(:each) do
    @buy_list = assign(:buy_list, BuyList.create!(
      :user_id => 1,
      :requested => false
    ))
  end

  it "renders the edit buy_list form" do
    render

    assert_select "form[action=?][method=?]", buy_list_path(@buy_list), "post" do

      assert_select "input#buy_list_user_id[name=?]", "buy_list[user_id]"

      assert_select "input#buy_list_requested[name=?]", "buy_list[requested]"
    end
  end
end
