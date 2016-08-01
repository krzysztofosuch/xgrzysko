require 'rails_helper'

RSpec.describe "matches/index", type: :view do
  before(:each) do
    assign(:matches, [
      Match.create!(),
      Match.create!()
    ])
  end

  it "renders a list of matches" do
    render
  end
end
