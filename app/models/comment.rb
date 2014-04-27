class Comment < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  scope :published, -> { where(status: "show") } 
  validates :message, presence: true
  
  def post_message
    "'" + self.message + "'
    
    부모님께 감사의 메시지 남기기 
    > http://event4.evezary.co.kr?s=ts"
  end
  
  def post
    user = self.user
    api = Koala::Facebook::API.new(self.user.authentications.first.token)
    # pictures = %w(posting_img posting_01 posting_02 posting_03)
    #  picture = "#{Rails.root.to_s}/app/assets/images/#{pictures.shuffle.last}.jpg"
    begin 
      api.put_wall_post(self.post_message)
    rescue Koala::Facebook::AuthenticationError
      Rails.logger.info "Koala::Facebook::AuthenticationError"
    end
  end
end
