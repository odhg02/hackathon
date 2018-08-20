class Review < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  mount_uploader :avatar, AvatarUploader
  paginates_per 3 
end
