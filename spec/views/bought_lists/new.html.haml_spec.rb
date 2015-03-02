require 'rails_helper'

RSpec.describe "bought_lists/new", :type => :view do
  before(:each) do
    assign(:bought_list, BoughtList.new(
      :total_usd => "9.99",
      :raw_order => "MyText",
      :buy_list => nil,
      :user => nil
    ))
  end

  it "renders new bought_list form" do
    render

    assert_select "form[action=?][method=?]", bought_lists_path, "post" do

      assert_select "input#bought_list_total_usd[name=?]", "bought_list[total_usd]"

      assert_select "textarea#bought_list_raw_order[name=?]", "bought_list[raw_order]"

      assert_select "input#bought_list_buy_list_id[name=?]", "bought_list[buy_list_id]"

      assert_select "input#bought_list_user_id[name=?]", "bought_list[user_id]"
    end
  end
end
