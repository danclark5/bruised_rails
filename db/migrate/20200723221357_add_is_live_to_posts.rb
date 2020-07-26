class AddIsLiveToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_live, :boolean
  end
end
