class AddCommentToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :comment, :string
  end
end
