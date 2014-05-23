require 'spec_helper'

describe Schedule do

  it { should belong_to :program }

  it 'should not allow a scheduled event to be created if an existing scheduled event has a duration overlapping the new start time' do
    scheduled_event1 = Schedule.create(:start_time => "12:00", :duration => 90, :program_id => 7)
    scheduled_event2 = Schedule.new(:start_time => "13:00", :duration => 60, :program_id => 5)
    scheduled_event2.save.should eq(false)
  end
  it 'should allow a scheduled event to be created if an existing scheduled event has a duration overlapping the new start time' do

    scheduled_event3 = Schedule.new(:start_time => "15:00", :duration => 60, :program_id => 5)
    scheduled_event3.save.should eq(true)
  end

end
