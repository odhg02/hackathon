class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:index, :new, :create, :show, :edit, :update, :destroy, :search]

  def matching
    @matching = Matching.create(user_id: current_user.id, post_id: params[:post_id], supply: params[:name].to_s, status: 1)
    redirect_to :back
  end

  def search
    @test = params[:category]
    @posts = Post.where(membertype: "2", category: params[:category])
    @posts = @posts.order("created_at DESC").page params[:page]
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.search(params[:membertype])
    @posts = Post.order("created_at DESC").page params[:page]
    @temp = params[:membertype]
    @users = User.where(user_type: "1")
    @mypages = Mypage.order(:cached_votes_up => :desc)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @matching = Matching.find_by(post_id: @post.id)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.membertype = current_user.user_type

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :category)
    end
end
