require 'spec_helper'

describe Project do
  it { should have_many :pledges }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:teaser) }
  it { should validate_presence_of(:description) }
  it { should validate_numericality_of(:goal).with_message("must be a number greater than 0") }

  describe "#goal" do
    it { should allow_value(1).for(:goal) }
    it { should allow_value(3.14).for(:goal) }
    it { should_not allow_value(0).for(:goal) }
    it { should_not allow_value(-1).for(:goal) }
    it { should_not allow_value(nil).for(:goal) }
    it { should_not allow_value('').for(:goal) }
  end
end
