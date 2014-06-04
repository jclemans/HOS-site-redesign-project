require 'spec_helper'

describe Episode do
  let(:stream_url){ ENV["stream_url"] }
  let(:duration){ 5 }
  let(:duration_seconds){ duration * 60 }
  let(:episode_file_directory){ ENV["episode_file_path"] }
  it { should have_many :tracks }

  it "takes program.duration and converts it to seconds and inserts that value into streamripper" do
    episode = Episode.new(:recorded_at => Time.now, :record_time => duration)
    episode.stub(:file_name).and_return "1.mp3"
    expected_file_path = "#{episode_file_directory}/1.mp3"
    episode.should_receive(:system).with("streamripper #{stream_url} -A -l #{duration_seconds} -i -m 300 -a -d #{expected_file_path}")
    episode.save
  end

  it "should know it's file path" do
    episode = Episode.create(:recorded_at => Time.now, :record_time => duration)
    episode.file_path.should == "#{episode_file_directory}/#{episode.id}.mp3"
  end

  it "should update its recording_file_name attribute after creation" do
    episode = Episode.create(:recorded_at => Time.now, :record_time => duration)
    episode.recording_file_name.should eq "#{episode_file_directory}/#{episode.id}.mp3"
  end
end
