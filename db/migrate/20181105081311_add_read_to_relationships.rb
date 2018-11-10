class AddReadToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :read, :boolean, default: false
  end
end
