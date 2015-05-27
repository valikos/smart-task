class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.string :file, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
    add_reference :attachments, :task, index: true, foreign_key: true, null: false
  end
end
