class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books, id: false, primary_key: :google_id do |t|
      t.string :google_id, size: 12, null: false
      t.integer :status, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :user_books, [:user_id, :google_id], unique: true
  end
end
