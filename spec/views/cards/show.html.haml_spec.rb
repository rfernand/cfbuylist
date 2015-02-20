require 'rails_helper'

RSpec.describe "cards/show", :type => :view do
  before(:each) do
    @card = assign(:card, Card.create!(
      :name => "Name",
      :price => 1.5,
      :link => "Link",
      :user_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Link/)
    expect(rendered).to match(/1/)
  end
end
