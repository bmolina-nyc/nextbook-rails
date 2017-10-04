class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books do |t|
      t.integer :status, null: false
      t.references :user, foreign_key: true
      t.string :google_id, null: false

      t.timestamps
    end
    add_index :user_books, [:user_id, :google_id], unique: true
    add_foreign_key :user_books, :books, column: :google_id,
                    primary_key: :google_id
  end
end
