class Qna < ActiveRecord::Base
  belongs_to :user
  has_many :qnacomments
  paginates_per 5
end
