class LocalSong < ActiveRecord::Base
  validate :filename, presence: true
  after_create :copy_file

  def copy_file
    FileUtils.copy_file @file[:tempfile].path, file_path
  end
  
  def file_path
    File.join LOCAL_MUSIC_FOLDER, filename
  end
  
  def file=(file)
    @file = file
    self.filename = "#{(0...8).map{65.+(rand(25)).chr}.join}_#{self.class.sanitize_filename(@file[:filename])}"
  end
  
  private
  
  def self.sanitize_filename(filename)
    filename.strip do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.gsub!(/^.*(\\|\/)/, '')

      # Finally, replace all non alphanumeric, underscore or periods with underscore
      name.gsub!(/[^\w\.\-]/, '_')
    end
  end
  
end
