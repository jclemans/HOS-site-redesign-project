class AddUserNamePhoneDjnameColumns < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string
  	add_column :users, :phone, :string
  	add_column :users, :djname, :string
  end
end
