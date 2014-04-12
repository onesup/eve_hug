class Comment < ActiveRecord::Base
  belongs_to :user
  
  scope :published, -> { where(status: "show") } 
end
