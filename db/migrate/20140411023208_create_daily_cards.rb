class CreateDailyCards < ActiveRecord::Migration
  def change
    create_table :daily_cards do |t|
      t.datetime :event_date
      t.text :memo
      t.string :card_image

      t.timestamps
    end
  end
end
