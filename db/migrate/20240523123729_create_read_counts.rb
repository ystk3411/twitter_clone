class CreateReadCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :read_counts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :tweet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
