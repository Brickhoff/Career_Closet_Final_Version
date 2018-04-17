require 'rails_helper'

RSpec.describe "histories/show", type: :view do
  before(:each) do
    @history = assign(:history, History.create!(
      :suit => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
