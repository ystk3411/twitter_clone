# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.0]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end
    add_index :likes, :user_id
    add_index :likes, :tweet_id
    add_index :likes, %i[user_id tweet_id], unique: true
  end
end
