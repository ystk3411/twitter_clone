# frozen_string_literal: true

class AddCommentIdToReadCounts < ActiveRecord::Migration[7.0]
  def change
    add_column :read_counts, :comment_id, :integer
  end
end
