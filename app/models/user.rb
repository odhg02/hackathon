class User < ActiveRecord::Base
  after_create :assign_default_role
  rolify
  acts_as_voter
  # 프로필 사진 추가를 위해 Uploader 생성
  mount_uploader :avatar, AvatarUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  # validates :name, presence: true, uniqueness: true
  has_many :posts
  has_many :reviews
  has_many :comments
  has_many :qnacomments
  # User Avatar Validation
  validates_integrity_of  :avatar
  validates_processing_of :avatar

  # validate :password_complexity
  
  # def password_complexity
  #   return if password.blank? || password =~ /^(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{6,15}$/

  #   errors.add :password, '를 숫자, 특수문자를 포함하여 6자 이상으로 설정해주세요.'
  # end

  scope :supply, -> {where(user_type: "1")}
  scope :demand, -> {where(user_type: "2")}
  scope :admin, -> {where(user_type: "3")}

  def assign_default_role
    if self.user_type == "1"
      add_role(:supply)
    elsif self.user_type =="2"
      add_role(:demand)
    else
      add_role(:admin)
    end
  end
  
  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end
end
