class DailyCard < ActiveRecord::Base
  mount_uploader :card_image_pc, MessageCardPcUploader
  mount_uploader :card_image_mobile, MessageCardMobileUploader
end
