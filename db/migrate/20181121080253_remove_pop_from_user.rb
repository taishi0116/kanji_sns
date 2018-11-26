class RemovePopFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :pop, :integer
  end
end
