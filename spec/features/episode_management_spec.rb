require 'spec_helper'

feature 'DJ records an episode' do

  before :each do
    sign_in(FactoryGirl.create(:dj, id: 14))
    FactoryGirl.create(:program, user_id: 14, id: 25)
    Schedule.create(start_time: "07:00", duration: 120, program_id: 25, day_of_week: 6)
  end

  scenario 'DJ signs in to record a new episode' do
    click_link "RECORD EPISODE"
    click_button "Record Episode"
    page.should have_content "Recording in progress"
  end

end
