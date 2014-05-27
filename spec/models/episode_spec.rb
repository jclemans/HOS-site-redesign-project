require 'spec_helper'

describe Episode do 
	let(:stream_url){ ENV["stream_url"] }
	let(:duration){ 5 }
	let(:duration_seconds){ duration * 60 }
	let(:episode_file_path){ ENV["episode_file_path"] }
	it { should have_many :tracks }

	it "takes program.duration and converts it to seconds and inserts that value into streamripper" do
		episode = Episode.new(:recorded_at => Time.now, :record_time => duration)
		episode.should_receive(:system).with("(streamripper #{stream_url} -A -l #{duration_seconds} -i -m 300 -a -d #{episode_file_path})")
		episode.save
	end
end