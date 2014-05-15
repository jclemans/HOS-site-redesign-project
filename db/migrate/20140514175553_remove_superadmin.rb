class RemoveSuperadmin < ActiveRecord::Migration
  def change
    remove_column :users, :superadmin
    User.find_by_email('default@example.com').try(:delete)
  end
end
