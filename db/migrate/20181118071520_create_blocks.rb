class CreateBlocks < ActiveRecord::Migration[5.2]
  def change
    create_table :blocks do |t|
      t.integer :blocking_id
      t.integer :blocked_id

      t.timestamps
    end
    add_index :blocks, :blocking_id
    add_index :blocks, :blocked_id
    add_index :blocks, [:blocking_id, :blocked_id], unique: true
  end
end
