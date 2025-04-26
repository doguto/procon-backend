class CreatePosts < ActiveRecord::Migration[8.0]
  def change
    create_table :posts do |t|
      t.integer :post_id
      t.integer :user_id
      t.text :text

      t.timestamps
    end
  end
end
