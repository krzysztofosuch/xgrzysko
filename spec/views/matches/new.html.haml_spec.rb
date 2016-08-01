require 'rails_helper'

RSpec.describe "matches/new", type: :view do
  before(:each) do
    assign(:match, Match.new())
  end

  it "renders new match form" do
    render

    assert_select "form[action=?][method=?]", matches_path, "post" do
    end
  end
end
