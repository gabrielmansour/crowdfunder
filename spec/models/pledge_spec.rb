require 'spec_helper'

describe Pledge do
  it { should validate_presence_of :user }
  it { should validate_presence_of :project }
  it { should validate_numericality_of(:amount) }

  describe "#amount" do
    it { should allow_value(1).for(:amount) }
    it { should_not allow_value(0).for(:amount) }
    it { should_not allow_value(-1).for(:amount) }
    it { should_not allow_value(nil).for(:amount) }
    it { should_not allow_value('').for(:amount) }
  end
end
