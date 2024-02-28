require 'rails_helper'

RSpec.describe "invites/index", type: :view do
  before(:each) do
    assign(:invites, [
      Invite.create!(
        title: "Title",
        description: "Description",
        company: nil,
        user: nil
      ),
      Invite.create!(
        title: "Title",
        description: "Description",
        company: nil,
        user: nil
      )
    ])
  end

  it "renders a list of invites" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Title".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Description".to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
