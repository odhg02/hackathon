class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  scope :published, -> {where.not(created_at: nil)}
  scope :unpublished, -> {where(created_at: nil)}
  
  def self.search(query)
    self.where("membertype LIKE ?","%#{query}%")
  end
end
