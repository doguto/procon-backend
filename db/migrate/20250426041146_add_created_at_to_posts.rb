class AddCreatedAtToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :created_at, :datetime
  end
end
