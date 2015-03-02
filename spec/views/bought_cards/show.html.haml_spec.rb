require 'rails_helper'

RSpec.describe "bought_cards/show", :type => :view do
  before(:each) do
    @bought_card = assign(:bought_card, BoughtCard.create!(
      :card => nil,
      :usd_price => "9.99",
      :user => nil,
      :condition => "Condition",
      :quantity => 1,
      :bought_list => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Condition/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(//)
  end
end
