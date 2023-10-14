class TopicsController < ApplicationController
  before_action :set_topic, only: %i[ show edit update destroy ]

  # GET /topics or /topics.json
  def index
    @topics = Topic.all
    #render json: @topics
  end
  def all_posts
    @topics = Topic.all
    @posts = Post.all
    @post = @posts.first
    @comments = Comment.where(post_id: @post.id)
    @tags =Tag.where(post_id: @post.id)
    # @comments =Comment.where(post_id: @posts.pluck(:id))
  end
  # GET /topics/1 or /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    #render json: @topic
    # @posts = @topic.posts
  end

  # GET /topics/new
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
  end

  # POST /topics or /topics.json
  def create
    @topic = Topic.new(topic_params)

     respond_to do |format|
      if @topic.save
        format.html { redirect_to topic_url(@topic), notice: "Topic #{@topic.title} was successfully created." }
        format.json { render 'show' , status: :created }
        #render json: @topic, status: :created
      else
        render json: @topic.errors, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /topics/1 or /topics/1.json
  def update
    respond_to do |format|
      if @topic.update(topic_params)
        format.html { redirect_to topic_url(@topic), notice: "Topic #{@topic.title} was successfully updated." }
        format.json { render 'show' , status: :created }
        #render json: @topic, status: :ok

      else
        format.html { render :edit, status: :unprocessable_entity }
        # render json: @topic.errors, status: :unprocessable_entity

      end
    end
  end

  # DELETE /topics/1 or /topics/1.json
  def destroy
    @topic.destroy
    respond_to do |format|
      format.html { redirect_to topics_url, notice: "Topic #{@topic.title} was successfully destroyed." }
      format.json
    end
    #render json: { head: :no_content }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_topic
    @topic = Topic.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def topic_params
    params.require(:topic).permit(:title,:user_id)
  end
end