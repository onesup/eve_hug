# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
if User.find_by_email("admin@admin.com").nil?
  User.create!(email:"admin@admin.com", password:"aaabbb", name:"관리자", phone:"010-9999-9999", birthday: Time.now) 
end

daily_card = DailyCard.new()
daily_card.card_image_pc = open(Rails.root.to_s + "/public/images/" + 'dailycard.png')
daily_card.card_image_mobile = open(Rails.root.to_s + "/public/images/" + 'dailycard.png')
daily_card.save()