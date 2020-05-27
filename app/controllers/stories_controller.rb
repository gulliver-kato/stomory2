class StoriesController < ApplicationController
  before_action :set_story, only: [:edit, :show, :update, :destroy]

  def index
    @story = Story.all
  end

  def show
  end

  def new
    if params[:back]
      @story = Story.new(story_params)
      @story.parts.build
    else
      @story = Story.new
      @story.parts.build
    end
  end

  def confirm
    @story = Story.new(story_params)
    @story.parts.build
  end

  def mystory
    if user_signed_in?
      @stories = current_user.stories
      @user = current_user
    else
      redirect_to root_path, notice: 'ログインしてくだい'
    end
  end

  def edit
    # @story.close_date = CloseDate.new if @story.close_date.blank?
  end

  def create
    @story = current_user.stories.build(story_params)
    if @story.save
      redirect_to story_path(@story), notice: 'storyを作成しました'
    else
      @story.parts.build if @story.parts.empty?
      render :new, notice: 'storyを作成できませんでした'
    end
  end

  def update
    if @story.update(story_params)
      redirect_to story_path(@story), notice: 'storyを更新しました'
    else
      render :edit, notice: 'storyを更新できませんでした'
    end
  end

  def destroy
    @story.destroy
    @story.parts.build
    respond_to do |format|
      format.html { redirect_to mystory_stories_path, notice: 'Story was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private
  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:admin_title, :title, :thumbnail_image, :thumbnail_image_cache, :user_id, parts_attributes: [:text, :image, :story_id, :image_cache, :_destroy])
  end
end
