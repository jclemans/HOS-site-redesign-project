require 'spec_helper'

describe Schedule do

  it { should belong_to :program }

  describe 'validate schedule conflicts' do
    it 'should not allow a program schedule to be created if it falls within an existing program schedule duration, within a single days 24 hour period' do
      schedule1 = Schedule.create(:start_time => "5:00", :duration => 90, :program_id => 7, :day_of_week => 1)
      schedule2 = Schedule.new(:start_time => "6:00", :duration => 60, :program_id => 5, :day_of_week => 1)
      schedule2.save.should eq(false)
    end

    it 'should allow a program schedule to be created if the schedule is available' do
      schedule1 = Schedule.create(:start_time => "15:00", :duration => 60, :program_id => 5, :day_of_week => 1)
      schedule2 = Schedule.new(:start_time => "15:00", :duration => 60, :program_id => 5, :day_of_week => 3)
      schedule2.save.should eq(true)
    end

    it 'should not allow a program schedule to be created, if it falls within an existing program schedule duration from the previous day' do
      schedule1 = Schedule.create(:start_time => "23:30", :duration => 120, :program_id => 9, :day_of_week => 1)
      schedule2 = Schedule.new(:start_time => "00:00", :duration => 60, :program_id => 7, :day_of_week => 2)
      schedule2.save.should eq(false)
    end
  end

  describe 'schedule with 3 segments' do
    let(:program){ FactoryGirl.build(:program) }
    let(:schedule){ Schedule.new(start_time: "12:00", duration: 90, program: program, day_of_week: 2) }

    it 'should include a start' do
      schedule.segments.should include('2-12:00')
    end

    it 'should include a middle segment' do
      schedule.segments.should include('2-12:30')
    end

    it 'should include an end segment' do
      schedule.segments.should include('2-13:00')
    end

    it 'should handle schedules spanning multiple days' do
      test_schedule = Schedule.new(start_time: "23:30", duration: 90, program: program, day_of_week: 2)
      test_schedule.segments.should include('3-00:30')
    end
    it 'should handle schedules spanning multiple weeks' do
      test_schedule = Schedule.new(start_time: "23:30", duration: 90, program: program, day_of_week: 6)
      test_schedule.segments.should include('0-00:30')
    end

  end
end
