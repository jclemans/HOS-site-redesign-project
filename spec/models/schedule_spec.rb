require 'spec_helper'

describe Schedule do

  it { should belong_to :program }

  it 'should not allow a scheduled event to be created if an existing scheduled event has a duration overlapping the new start time' do
    program1 = FactoryGirl.build(:schedule)
    program1.save(schedule_params)
    program2 = FactoryGirl.build(:schedule)
    program2.save(schedule_params).should eq(false)
  end
end
