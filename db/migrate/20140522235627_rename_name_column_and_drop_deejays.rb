class RenameNameColumnAndDropDeejays < ActiveRecord::Migration
  def change
    rename_column :programs, :name, :title
    remove_column :programs, :deejays
  end
end
