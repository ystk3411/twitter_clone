# frozen_string_literal: true

class AddCommentIdToTweets < ActiveRecord::Migration[7.0]
  def change
    add_column :tweets, :comment_id, :integer
  end
end
