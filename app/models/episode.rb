class Episode < ActiveRecord::Base
  belongs_to :program
  has_many :tracks
  before_destroy :delete_file
  
  LOCAL_ROOT = 'static'
  PUBLIC_ROOT = 'episodes'
  
  def finish!
    self.update_attribute :is_finished, true
    program.enforce_max_episodes
    delete_cue_file
  end
  
  def file_name
    "#{id}.mp3"
  end
  
  def file_local_path
    File.join LOCAL_ROOT, PUBLIC_ROOT, file_name
  end
  
  def file_public_path
    "/#{PUBLIC_ROOT}/#{file_name}"
  end
  
  private
  
  def delete_file
    File.delete(file_local_path) if File.exists? file_local_path
  end
  
  def delete_cue_file
    File.delete File.join(LOCAL_ROOT, PUBLIC_ROOT, "#{id}.cue")
  end
end
