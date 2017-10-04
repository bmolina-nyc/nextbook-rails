class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books, id: false, primary_key: :google_id do |t|
      t.string :google_id, size: 12, null: false
      t.string :title, null: false
      t.string :subtitle

      t.timestamps
    end
    add_index :books, :google_id, unique: true
  end
end
