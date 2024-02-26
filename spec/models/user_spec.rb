require 'rails_helper'

RSpec.describe User, type: :model do

  describe "#enums" do
    it { is_expected.to define_enum_for(:role).with_values([:user, :admin]) }
  end
end
