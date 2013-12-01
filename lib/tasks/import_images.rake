namespace :import do
  task :images => :environment do
    Program.find_each do |program|
      old_path = "https://s3.amazonaws.com/houseofsound-development/Program/huge/#{program.amazon_filename}"
      program.avatar = open(old_path)
      program.save
      puts "process #{program.name}"
    end
  end
end
