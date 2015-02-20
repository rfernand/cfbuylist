require 'rails_helper'

RSpec.describe "cards/index", :type => :view do
  before(:each) do
    assign(:cards, [
      Card.create!(
        :name => "Name",
        :price => 1.5,
        :link => "Link",
        :user_id => 1
      ),
      Card.create!(
        :name => "Name",
        :price => 1.5,
        :link => "Link",
        :user_id => 1
      )
    ])
  end

  it "renders a list of cards" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Link".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
