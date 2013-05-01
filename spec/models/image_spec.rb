require 'spec_helper'

describe Image do
  it { should validate_presence_of :file }
  it { should validate_presence_of :project }
end
