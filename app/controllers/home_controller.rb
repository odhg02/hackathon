class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:temp]
  before_action :set_mypage, only: [:temp]
  
  def index

  end
  
  def temp
    @mypage = Mypage.find_by(user_id: @user)
    if @mypage.nil?
      @myp = Mypage.new
      @myp.user_id = current_user.id
      @myp.save
      redirect_to '/'
    else

    end
  end
  
  def matching
  end
  
  private
    def set_mypage
      @user = User.find(current_user.id)
    end  
end
