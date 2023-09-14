class TagsController < ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]

  def index
    @tags =Tag.all
  end
  def new
     @tag =Tag.new
  end

  def create
    @tag =Tag.new(tag_params)
    respond_to do |format|
      if @tag.save
        format.html{redirect_to tags_path(@tags) ,notice: "tag is successfully created"}
      else
        format.html{render :new}
      end
    end
  end
  def show
  end

    def edit
      @tag = Tag.find(params[:id])
    end
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html{ redirect_to tag_path(@tag) ,notice: "tag is successfully created"}
      else
        render :new
      end
    end
  end
  def destroy
    @tag.destroy
    redirect_to tags_url ,notice: "tag deleted"
  end


  private
  def set_tag
    @tag =Tag.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:name)
  end



end
