require 'rails_helper'

RSpec.describe "matches/show", type: :view do
  before(:each) do
    @match = assign(:match, Match.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
