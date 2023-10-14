class PostsController < ApplicationController
  include CanCan::ControllerAdditions
  load_and_authorize_resource
  before_action :set_topic ,except: :all_posts
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  # GET /topics/:topic_id/posts or /topics/:topic_id/posts.json
  def index
    @posts = @topic.posts.page(params[:page]).per(3)
    @comments =Comment.where(post_id: @posts.pluck(:id))
    @average_ratings = Hash[Rating.group(:post_id).average(:value).map { |k, v| [k, v.round(1)] }]
  end

  def all_posts
    from_date = params[:from_date].presence || 1.day.ago.to_date
    to_date = params[:to_date].presence || Date.today

    from_date = Date.parse(from_date.to_s)
    to_date = Date.parse(to_date.to_s)

    @posts = Post.left_joins(:ratings, :comments)
                 .includes([:topic])
                 .includes([:tags])
                 .select('posts.*, AVG(ratings.value) as average_rating, COUNT(comments.id) as comments_count')
                 .group('posts.id')
                 .filter_by_date(from_date, to_date)
                 .page(params[:page]).per(10)

  end

  def mark_as_read
    @post = Post.find(params[:id])
    @post.mark_as_read(current_user) if user_signed_in?

    respond_to do |format|
      format.js
    end
  end
  # GET /topics/:topic_id/posts/1 or /topics/:topic_id/posts/1.json
  def show
    @topic = Topic.find(params[:topic_id])
    @posts = @topic.posts.find(params[:id])
    if user_signed_in? && !@post.marked_as_read?(current_user)
      # Mark the post as read
      @post.mark_as_read(current_user)
    end
    @ratings = @post.ratings.group(:value).count
  end

  # GET /topics/:topic_id/posts/new
  def new
    @post = @topic.posts.new

  end

  # GET /topics/:topic_id/posts/1/edit
  def edit

  end

  def create
    #@post = @topic.posts.new(post_params)
    @topic = Topic.find(params[:topic_id]) # Assuming you already have this line to set the topic
    @post = @topic.posts.build(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html{redirect_to  topic_posts_path(@topic, @post), notice: 'Post was successfully created.'}
        format.js
      else
        format.html { render :new, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to params[:referrer] || topic_post_url(@topic, @post), notice: 'Post was successfully updated.' }

      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/:topic_id/posts/1 or /topics/:topic_id/posts/1.json
  def destroy
    @post.ratings.destroy_all
    @post.tags.clear
    @post.destroy

    respond_to do |format|
      format.html { redirect_to  request.referer || topic_posts_path(@topic), notice: "Post was successfully destroyed." }
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_post
    # @post = @topic.posts.find(params[:id])
    @post = Post.find(params[:id])
  end
  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content, :topic_id,:user_id , :referrer,:image, tag_ids: [])
  end

end