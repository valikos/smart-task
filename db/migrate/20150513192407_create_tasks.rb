class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, null: false, limit: 160
      t.boolean :status, null: false, default: false
      t.timestamps null: false
    end
    add_reference :tasks, :project, index: true, foreign_key: true, null: false
  end
end
