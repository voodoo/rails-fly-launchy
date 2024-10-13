class StoriesController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]
  before_action :resume_session, only: [:index, :show]

  before_action :set_story, only: %i[ show edit update destroy upvote ]

  # GET /stories or /stories.json
  def index
    @stories = Story.order(votes_count: :desc)
  end

  # GET /stories/1 or /stories/1.json
  def show
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
  end

  # POST /stories or /stories.json
  def create
    @story = Story.new(story_params)

    respond_to do |format|
      if @story.save
        format.html { redirect_to @story, notice: "Story was successfully created." }
        format.json { render :show, status: :created, location: @story }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stories/1 or /stories/1.json
  def update
    respond_to do |format|
      if @story.update(story_params)
        format.html { redirect_to @story, notice: "Story was successfully updated." }
        format.json { render :show, status: :ok, location: @story }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @story.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stories/1 or /stories/1.json
  def destroy
    @story.destroy!

    respond_to do |format|
      format.html { redirect_to stories_path, status: :see_other, notice: "Story was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  # POST /stories/1/upvote
  def upvote
    @story = Story.find(params[:id])
    vote = @story.votes.new(user: Current.user)
    vote.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("story_#{@story.id}", partial: 'stories/vote', locals: { story: @story }),
          #turbo_stream.prepend("flash", partial: 'layouts/flash', locals: { message: "You've successfully upvoted this story.", type: 'notice' })
        ]
      end
      format.html { redirect_to @story, notice: "You've successfully upvoted this story." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_story
      @story = Story.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def story_params
      params.expect(story: [ :title, :description, :user_id, :url, :url_protocol ])
    end
end
