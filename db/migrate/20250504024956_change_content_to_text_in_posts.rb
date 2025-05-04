class ChangeContentToTextInPosts < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :content, :text
  end
end