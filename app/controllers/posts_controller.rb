class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  # GET /posts
  # GET /posts.json
  def index
    if params.has_key?(:category)
      @category = Category.find_by_name(params[:category])
      @posts = Post.where(category: @category)
    else
      @posts = Post.all.order("created_at DESC")
      #paginate(:page => params[:page], :per_page =>6 )
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new
    @comments = @post.comments.order("created_at DESC")

    # if @post.nil?
    #   flash[:notice] = "Oups, we can't find a News for this url"
    #   redirect_to root_path
    # end
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

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Your News was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        format.js
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Your News was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: ' Your News was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @post.upvote_from current_user, :vote_weight => 3 
    redirect_to post_path
  end

  def downvote
    @post.downvote_from current_user
    redirect_to post_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :author, :description, :category_id, :image)
    end
end
