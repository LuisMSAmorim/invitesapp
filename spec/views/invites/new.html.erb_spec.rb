require 'rails_helper'

RSpec.describe "invites/new", type: :view do
  before(:each) do
    assign(:invite, Invite.new(
      title: "MyString",
      description: "MyString",
      company: nil,
      user: nil
    ))
  end

  it "renders new invite form" do
    render

    assert_select "form[action=?][method=?]", invites_path, "post" do

      assert_select "input[name=?]", "invite[title]"

      assert_select "input[name=?]", "invite[description]"

      assert_select "input[name=?]", "invite[company_id]"

      assert_select "input[name=?]", "invite[user_id]"
    end
  end
end
