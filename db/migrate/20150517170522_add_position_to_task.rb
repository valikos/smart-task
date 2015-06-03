class AddPositionToTask < ActiveRecord::Migration
  def up
    add_column :tasks, :position, :integer, null: false
  end

  def down
    remove_column :tasks, :position
  end
end
