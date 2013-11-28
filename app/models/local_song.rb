class LocalSong
  include DataMapper::Resource
  property :id, Serial
  property :artist_name, String, :length => 255
  property :title, String, :length => 255
  property :email, String, :length => 255
  property :filename, String, :length => 255
  property :created_at, DateTime
  
  validates_present :filename
  
  after :create do
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
      name.gsub! /^.*(\\|\/)/, ''

      # Finally, replace all non alphanumeric, underscore or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end
  
end