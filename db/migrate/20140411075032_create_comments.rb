class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :message
      t.string :status, :default => "show"

      t.timestamps
    end
  end
end
