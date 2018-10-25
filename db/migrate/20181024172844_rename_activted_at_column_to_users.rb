class RenameActivtedAtColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :activted_at, :activated_at
  end
end
