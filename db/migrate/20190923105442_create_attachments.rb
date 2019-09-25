class CreateAttachments < ActiveRecord::Migration[6.0]
  def change
    create_table :attachments do |t|
      t.text :encryption_iv, null: false
      t.text :encryption_key, null: false
      t.text :url, null: false
      t.uuid :identifier, null: false

      t.timestamps
    end

    add_index :attachments, :identifier, unique: true
  end
end
