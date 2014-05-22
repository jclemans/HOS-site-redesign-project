class AddAdminToDb < ActiveRecord::Migration
  def change
    admin = User.create(djname: "djadmin", email: "admin@houseofsound.org", password: "password", password_confirmation: "password", phone: "503-575-9344", name: "Admin")
    admin.add_role "Admin"
  end
end
