class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :reviews
  has_many :matchings
  scope :published, -> {where.not(created_at: nil)}
  scope :unpublished, -> {where(created_at: nil)}
  paginates_per 3 
  def self.search(query)
    self.where("membertype LIKE ?","%#{query}%")
  end
end
