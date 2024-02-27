require 'rails_helper'

RSpec.describe "invites/edit", type: :view do
  let(:invite) {
    Invite.create!(
      title: "MyString",
      description: "MyString",
      company: nil,
      user: nil
    )
  }

  before(:each) do
    assign(:invite, invite)
  end

  it "renders the edit invite form" do
    render

    assert_select "form[action=?][method=?]", invite_path(invite), "post" do

      assert_select "input[name=?]", "invite[title]"

      assert_select "input[name=?]", "invite[description]"

      assert_select "input[name=?]", "invite[company_id]"

      assert_select "input[name=?]", "invite[user_id]"
    end
  end
end
