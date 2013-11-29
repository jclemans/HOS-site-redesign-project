require 'spec_helper'

describe Program do
  describe '.active scope' do
    let!(:active_program){ FactoryGirl.create :program }
    let!(:inactive_program){ FactoryGirl.create :inactive_program }

    it "should include active programs in active scope" do
      Program.active.should include(active_program)
    end

    it "should not include inactive programs in active scope" do
      Program.active.should_not include(inactive_program)
    end

  end
end
