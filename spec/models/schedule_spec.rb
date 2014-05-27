require 'spec_helper'

describe Schedule do

  it { should belong_to :program }

  describe 'validate schedule conflicts' do
    it 'should not allow a program schedule to be created if it falls within an existing program schedule duration, within a single days 24 hour period' do
      schedule1 = Schedule.create(:start_time => "5:00", :duration => 90, :program_id => 7, :days_of_week => ["Monday"])
      schedule2 = Schedule.new(:start_time => "6:00", :duration => 60, :program_id => 5, :days_of_week => ["Monday"])
      schedule2.save.should eq(false)
    end

    it 'should allow a program schedule to be created if the schedule is available' do
      schedule1 = Schedule.create(:start_time => "15:00", :duration => 60, :program_id => 5, :days_of_week => ["Monday"])
      schedule2 = Schedule.new(:start_time => "15:00", :duration => 60, :program_id => 5, :days_of_week => ["Wednesday"])
      schedule2.save.should eq(true)
    end

    it 'should not allow a program schedule to be created, if it falls within an existing program schedule duration from the previous day' do
      schedule1 = Schedule.create(:start_time => "23:30", :duration => 120, :program_id => 9, :days_of_week => ["Monday"])
      schedule2 = Schedule.new(:start_time => "00:15", :duration => 60, :program_id => 7, :days_of_week => ["Tuesday"])
      schedule2.save.should eq(false)
    end
  end
end
