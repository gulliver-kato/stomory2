class StoriesController < ApplicationController
  before_action :set_story, only: [:edit, :show, :update, :destroy]

  def index
    @story = Story.all.order(created_at: 'DESC')
  end

  def show
  end

  def new
    if user_signed_in?
      if params[:back]
        @story = Story.new(story_params)
        @story.parts.build
      else
        @story = Story.new
        @story.parts.build
      end
    else
      redirect_to root_path, notice: 'ログインしてくだい'
    end
  end

  # def confirm
  #   @story = Story.new(story_params)
  #   @story.parts.build
  # end

  def mystory
    if user_signed_in?
      @stories = current_user.stories.order(created_at: 'DESC')
      @user = current_user
    else
      redirect_to root_path, notice: 'ログインしてくだい'
    end
  end

  def edit
    @story.thumbnail_image.cache! unless @story.thumbnail_image.blank?
    @story.parts do |part|
      part.image.chache! unless part.image.blank?
    end
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
    params.require(:story).permit(:id, :admin_title, :title, :thumbnail_image, :thumbnail_image_cache, :user_id, parts_attributes: [:id, :text, :image, :story_id, :image_cache, :_destroy])
  end
end
