class MypagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mypage, only: [:index, :upvote, :downvote]

  # 기본적으로 Mypage 모델은 User 모델을 참조하는데,
  # Mypage_id랑 User_id 값을 똑같이 저장하도록 해놓아서
  # 실제적으로는 User_id라고 봐도 됨
  # 내가 좋아요 편하게 만드려고 임의로 해놓은거임

  def index
    @mypage = Mypage.find_by(user_id: @user)
    @posts = Post.where(user_id: @user)
    @qnas = Qna.where(user_id: @user)
    @reviews = Review.where(user_id: @user)
    # Portfolio 모델은 Mypage를 참조
    @portfolio = Portfolio.find_by(mypage_id: @mypage)
  end
  
  def upvote
    @mypage = Mypage.find_by(user_id: @user)
   
    #만약 '찬성' 투표를 이미 한 경우 : '찬성' 투표 취소
    if ((current_user.voted_up_on? @mypage) == true)
      @mypage.unliked_by current_user
      redirect_to(request.referrer, :notice => '해당 글의 추천을 취소하셨습니다.')
    else
      @mypage.upvote_by current_user
      redirect_to(request.referrer, :notice => '해당 글을 추천하셨습니다.')
    end
  end
 
  # 투표 관련 Controller 내용 : 반대
  def downvote
    @mypage = Mypage.find_by(user_id: @user)
        
    #만약 '반대' 투표를 이미 한 경우 : '반대' 투표 취소
    if ((current_user.voted_down_on? @mypage) == true)
      @mypage.unliked_by current_user    
      redirect_to(request.referrer, :notice => '해당 글의 반대를 취소하셨습니다.')
    else
      @mypage.downvote_from current_user
      redirect_to(request.referrer, :notice => '해당 글을 반대하셨습니다.')
    end
  end
  
  private
    def set_mypage
      @user = User.find(params[:user_id])
      @mypage = Mypage.find_by(user_id: @user)
    end    
end
