class AddCommentsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :comments_count, :integer
    add_column :users, :viral_actions_count, :integer
  end
end
