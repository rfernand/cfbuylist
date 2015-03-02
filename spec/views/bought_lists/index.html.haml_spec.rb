require 'rails_helper'

RSpec.describe "bought_lists/index", :type => :view do
  before(:each) do
    assign(:bought_lists, [
      BoughtList.create!(
        :total_usd => "9.99",
        :raw_order => "MyText",
        :buy_list => nil,
        :user => nil
      ),
      BoughtList.create!(
        :total_usd => "9.99",
        :raw_order => "MyText",
        :buy_list => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of bought_lists" do
    render
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
