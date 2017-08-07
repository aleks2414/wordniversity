class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_university

  # GET /experiences
  # GET /experiences.json
  def index
    @experiences = Experience.all
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
  end

  # GET /experiences/new
  def new
    @experience = Experience.new
  end

  # GET /experiences/1/edit
  def edit
  end

  # POST /experiences
  # POST /experiences.json
def create
  puts params['experiences']
    if params.has_key?("experience")
      Experience.create(experience_params(params["experience"]))
    else
      params["experiences"].each do |experience|
        if experience["experience"] != ""          
          @new_experience = Experience.new(experience_params(experience))
          @new_experience.user_id = current_user.id
          @new_experience.university_id = @university.id
          @new_experience.save
        end
      end
      redirect_to @university
    end
end

  # PATCH/PUT /experiences/1
  # PATCH/PUT /experiences/1.json
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @university, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to @university, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      @experience = Experience.find(params[:id])
    end

    def set_university
      @university = University.friendly.find(params[:university_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params(my_params)
      my_params.permit(:experience, :user_id, :university_id, experiences: [:experience])
    end
end
