require 'rails_helper'

RSpec.describe "bought_lists/show", :type => :view do
  before(:each) do
    @bought_list = assign(:bought_list, BoughtList.create!(
      :total_usd => "9.99",
      :raw_order => "MyText",
      :buy_list => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
