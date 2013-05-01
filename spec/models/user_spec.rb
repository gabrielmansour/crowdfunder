require 'spec_helper'

describe User do
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe "#name" do
    let(:user) { User.new }
    subject { user.name }

    before do
      user.first_name = "Bob"
      user.last_name = "Dylan"
    end

    it { should == "Bob Dylan" }
  end
end
