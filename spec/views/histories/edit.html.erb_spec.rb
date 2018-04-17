require 'rails_helper'

RSpec.describe "histories/edit", type: :view do
  before(:each) do
    @history = assign(:history, History.create!(
      :suit => nil,
      :user => nil
    ))
  end

  it "renders the edit history form" do
    render

    assert_select "form[action=?][method=?]", history_path(@history), "post" do

      assert_select "input[name=?]", "history[suit_id]"

      assert_select "input[name=?]", "history[user_id]"
    end
  end
end
