require 'net/http'
class DownloadPhotos

  def self.run_all
    Program.all.each do |program|
      if program.amazon_filename != nil
        file_ext = program.amazon_filename
        url = "https://s3.amazonaws.com/houseofsound-development/Program/large/#{file_ext}"
        program.update_attributes(:avatar => URI.parse(url))
      end
    end
  end
end