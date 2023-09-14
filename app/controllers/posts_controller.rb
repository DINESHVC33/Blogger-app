class PostsController < ApplicationController
  before_action :set_topic
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def index
    @posts = @topic.posts
    @comments =Comment.where(post_id: @posts.pluck(:id))
  end

  # GET /topics/:topic_id/posts/1 or /topics/:topic_id/posts/1.json
  def show
    @comment=@post.comments.build
  end

  # GET /topics/:topic_id/posts/new
  def new
    @post = @topic.posts.new
  end

  # GET /topics/:topic_id/posts/1/edit
  def edit
  end

  # POST /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def create
    @post = @topic.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to topic_post_url(@topic, @post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: [@topic, @post] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topics/:topic_id/posts/1 or /topics/:topic_id/posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to topic_post_url(@topic, @post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: [@topic, @post] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/:topic_id/posts/1 or /topics/:topic_id/posts/1.json
  def destroy
    @post.destroy

    respond_to do |format|
      format.html { redirect_to topic_posts_url(@topic), notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end
end