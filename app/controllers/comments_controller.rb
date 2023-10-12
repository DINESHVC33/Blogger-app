class CommentsController < ApplicationController
  before_action :set_topic
  before_action :set_post
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  include CanCan::ControllerAdditions
  load_and_authorize_resource
  # GET /comments or /comments.json
  def index
    @topic =Topic.find(params[:topic_id])
    @post=@topic.posts.find(params[:post_id])
    @comments=@post.comments
    @ratings = Comment.joins(:user_comment_ratings).distinct
  end

  # GET /comments/1 or /comments/1.json
  def show
     @ratings = @comment.user_comment_ratings
  end

  # GET /comments/new
  def new
    @comment = @post.comments.new
  end
  def ratings
    @comment = Comment.find(params[:id])
    @ratings = @comment.user_comment_ratings
  end
  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  # def create
  #   @comment = @post.comments.new(comment_params)
  #   @comment.topic = @topic
  #
  #   respond_to do |format|
  #     if @comment.save
  #       format.html { redirect_to topic_post_url(@topic, @post), notice: 'Comment was successfully created.' }
  #     else
  #       format.html { render :new }
  #     end
  #   end
  # end
  def create
  # @topic = Topic.find(params[:topic_id])
  # @post = @topic.posts.find(params[:post_id])
  # @comment = @post.comments.new(comment_params)
  @topic = Topic.find(params[:topic_id])
  @post = @topic.posts.find(params[:post_id])
  @comment = @post.comments.build(comment_params)
  @comment.user = current_user

  respond_to do |format|
    if @comment.save
      format.html { redirect_to params[:referrer] || topic_post_comments_url(@topic, @post), notice: 'Comment was successfully created.' }
    else
      format.html { render :new }
    end
  end
end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to params[:referrer] || topic_post_comment_url(@topic, @post), notice: 'Comment was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy

    @comment.destroy
    respond_to do |format|
      format.html { redirect_to params[:referrer] || topic_post_comments_url(@topic, @post), notice: 'Comment was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    @post = @topic.posts.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:post_id,:referrer , :text)
  end
end
