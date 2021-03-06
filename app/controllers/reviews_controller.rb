#class ReviewsController < InheritedResources::Base
class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  
  # GET /reviews
  # GET /reviews.json
  def index
    @review = Review.all
    @review = Review.order("created_at DESC").page params[:page]
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show

  end

  # GET /reviews/new
  def new
    @review = Review.new
    @temp = params[:post_id]
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.post_id = params[:post_id]
    @review.rating = params[:rating].to_i
    @matching = Matching.find_by(post_id: params[:post_id])
    @supply = User.find_by(email: @matching.supply.to_s)
    
    if @supply.rating == 0.0
      @supply.rating = params[:rating].to_i
    else
      @supply.rating = ((@supply.rating + params[:rating].to_i) / 2).round(1)
    end
    
    @supply.save
    
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Notice was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Notice was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:title, :content, :rating, :avatar)
    end
end

