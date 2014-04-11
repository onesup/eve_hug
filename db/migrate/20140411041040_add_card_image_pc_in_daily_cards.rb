class AddCardImagePcInDailyCards < ActiveRecord::Migration
  def change
    add_column :daily_cards, :card_image_pc, :string
    add_column :daily_cards, :card_image_mobile, :string
    remove_column :daily_cards, :card_image
  end
end
