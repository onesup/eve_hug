class Channel < ActiveRecord::Base
  validates :code, uniqueness: true
end
