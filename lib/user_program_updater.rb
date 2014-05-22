class UserProgramUpdater
	def self.run_all
		Program.all.each do |p|
			dj = User.where(djname: p.deejays).last
			update_program dj, p
		end
	end

	def self.update_program dj, program
		program.update_attribute :user_id, dj.id
		dj.add_role "DJ"
	rescue
		if program.email.blank?
			email = program.id
		else
			email = program.email
		end
		dj = User.create(djname: program.deejays, email: email, password: "password", password_confirmation: "password", phone: program.deejays, name: program.deejays)
		program.update_attribute :user_id, dj.id
		dj.add_role "DJ"
	end
end
