require 'spec_helper'

describe Program do
	it { should belong_to :user }
  it { should have_many :schedules }
  it { should have_many :episodes }
  it { should validate_presence_of :user_id }
end
