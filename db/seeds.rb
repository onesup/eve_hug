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
a = User.create!(email:"m1@evezary.co.kr", password:"aaabbb", name:"김이브", phone:"010-9998-9999", birthday: Time.now) 
b = User.create!(email:"m2@evezary.co.kr", password:"aaabbb", name:"김자리", phone:"010-9997-9999", birthday: Time.now) 
c = User.create!(email:"m3@evezary.co.kr", password:"aaabbb", name:"박이브", phone:"010-9996-9999", birthday: Time.now) 
d = User.create!(email:"m4@evezary.co.kr", password:"aaabbb", name:"박자리", phone:"010-9995-9999", birthday: Time.now) 

daily_card = DailyCard.new()
daily_card.card_image_pc = open(Rails.root.to_s + "/public/images/" + 'dailycard.png')
daily_card.card_image_mobile = open(Rails.root.to_s + "/public/images/" + 'dailycard.png')
daily_card.save()

Comment.create!(user: a, message:"엄마 언제나 감사해요")
Comment.create!(user: b, message:"엄마 언제나 감사해요")
Comment.create!(user: c, message:"엄마 언제나 감사해요")
Comment.create!(user: d, message:"엄마 언제나 감사해요")
Comment.create!(user: a, message:"아빠 언제나 감사해요")
Comment.create!(user: b, message:"아빠 언제나 감사해요")
Comment.create!(user: c, message:"아빠 언제나 감사해요")
Comment.create!(user: d, message:"아빠 언제나 감사해요")

Channel.create!(code: "fb", name: "페이스북", sort_order: 1)
Channel.create!(code: "ks", name: "카카오스토리", sort_order: 2)
Channel.create!(code: "kt", name: "카카오톡", sort_order: 3)
Channel.create!(code: "tw", name: "트위터", sort_order: 4)