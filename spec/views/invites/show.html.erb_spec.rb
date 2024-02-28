require 'rails_helper'

RSpec.describe "invites/show", type: :view do
  before(:each) do
    assign(:invite, Invite.create!(
      title: "Title",
      description: "Description",
      company: nil,
      user: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Description/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
