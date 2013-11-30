class CreateDjApplications < ActiveRecord::Migration
  def change
    create_table :dj_applications do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :show_description
      t.string :show_name
      t.string :dj_name
      t.boolean :is_cost_ok
      t.text :availability
      t.text :internal_contacts

      t.timestamps
    end
  end
end
