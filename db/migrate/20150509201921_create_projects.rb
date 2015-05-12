class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false, limit: 160

      t.timestamps null: false
    end
  end
end
