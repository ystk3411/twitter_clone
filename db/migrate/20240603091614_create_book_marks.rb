class CreateBookMarks < ActiveRecord::Migration[7.0]
  def change
    create_table :book_marks do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end
    add_index :book_marks, :user_id
    add_index :book_marks, :tweet_id
    add_index :book_marks, %i[user_id tweet_id], unique: true
  end
end
