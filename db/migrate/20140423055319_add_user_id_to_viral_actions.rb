class AddUserIdToViralActions < ActiveRecord::Migration
  def change
    add_column :viral_actions, :user_id, :integer
  end
end
