require 'rails_helper'

RSpec.describe "buy_lists/index", :type => :view do
  before(:each) do
    assign(:buy_lists, [
      BuyList.create!(
        :user_id => 1,
        :requested => false
      ),
      BuyList.create!(
        :user_id => 1,
        :requested => false
      )
    ])
  end

  it "renders a list of buy_lists" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
