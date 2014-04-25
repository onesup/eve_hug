class AddDeviceToComments < ActiveRecord::Migration
  def change
    add_column :comments, :device, :string
  end
end
