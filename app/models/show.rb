class Show
  include DataMapper::Resource
  property :id, Serial
  property :when, DateTime
  property :program_id, Integer
  property :is_finished, Boolean, :default => false
  belongs_to :program
  
  before :destroy, :delete_file
  
  LOCAL_ROOT = 'static'
  PUBLIC_ROOT = 'shows'
  
  def finish!
    update :is_finished => true
    program.enforce_max_shows
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