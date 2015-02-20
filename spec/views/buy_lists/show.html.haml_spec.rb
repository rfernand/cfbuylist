require 'rails_helper'

RSpec.describe "buy_lists/show", :type => :view do
  before(:each) do
    @buy_list = assign(:buy_list, BuyList.create!(
      :user_id => 1,
      :requested => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/false/)
  end
end
