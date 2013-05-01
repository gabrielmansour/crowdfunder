require 'spec_helper'

describe Pledge do
  it { should validate_presence_of :user }
  it { should validate_presence_of :project }
  it { should validate_numericality_of(:amount) }
end
