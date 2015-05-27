class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content, null: false, limit: 160

      t.timestamps null: false
    end
    add_reference :comments, :task, index: true, foreign_key: true, null: false
  end
end
