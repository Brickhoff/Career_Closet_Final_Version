require 'rails_helper'

RSpec.describe "histories/new", type: :view do
  before(:each) do
    assign(:history, History.new(
      :suit => nil,
      :user => nil
    ))
  end

  it "renders new history form" do
    render

    assert_select "form[action=?][method=?]", histories_path, "post" do

      assert_select "input[name=?]", "history[suit_id]"

      assert_select "input[name=?]", "history[user_id]"
    end
  end
end
