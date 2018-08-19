class PortfoliosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_portfolio, only: [:create, :edit, :update]
  
  def index
    @portfolio = Portfolio.find_by(user_id: @user)
  end
   
  def create
    @portfolio = Portfolio.new
    @portfolio.mypage_id = @mypage.id
    @portfolio.name = params[:name]
    @portfolio.career = params[:career]
    @portfolio.grade = params[:grade]
    @portfolio.introduction = params[:introduction]
    @portfolio.save
    
    
    # 제발 주소 적을 때 틀리지 말자 ...... 아까도 /mypage/로 되어 있었음
    redirect_to "/mypages/#{@user.id}"
  end
    
  def new
  end
  
  def edit
    @portfolio = Portfolio.find_by(mypage_id: @mypage)
  end
  
  def update
    portfolio = Portfolio.find_by(mypage_id: @mypage)
    portfolio.name = params[:name]
    portfolio.career = params[:career]
    portfolio.grade = params[:grade]
    portfolio.introduction = params[:introduction]
    portfolio.save
    
    redirect_to "/mypages/#{@user.id}"
  end
  
  private
    def set_portfolio
      @user = User.find(current_user.id)
      @mypage = Mypage.find_by(user_id: @user)
      @portfolio = Portfolio.find_by(mypage_id: @mypage)
    end
end
