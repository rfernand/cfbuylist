require 'rails_helper'

RSpec.describe "buy_lists/new", :type => :view do
  before(:each) do
    assign(:buy_list, BuyList.new(
      :user_id => 1,
      :requested => false
    ))
  end

  it "renders new buy_list form" do
    render

    assert_select "form[action=?][method=?]", buy_lists_path, "post" do

      assert_select "input#buy_list_user_id[name=?]", "buy_list[user_id]"

      assert_select "input#buy_list_requested[name=?]", "buy_list[requested]"
    end
  end
end
