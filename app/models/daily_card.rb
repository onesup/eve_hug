class DailyCard < ActiveRecord::Base
  mount_uploader :card_image_pc, MessageCardPcUploader
  mount_uploader :card_image_mobile, MessageCardMobileUploader
  
  def self.today_image
    event_day = Time.now.beginning_of_day
    if self.where(:event_date => event_day).empty?
      result = self.last
    else
      result = self.where(:event_date => event_day)
    end
  end
  
end
