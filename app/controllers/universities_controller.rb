class UniversitiesController < ApplicationController
  before_action :set_university, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit]

  # GET /universities
  # GET /universities.json
  def index
    @q = University.ransack(params[:q])
    @universities = @q.result.uniq

    @universities = @universities.order('id ASC').paginate(:page => params[:page], :per_page => 12)

    @arrUnis = @universities.to_a

    @universityy = University.all

    @experiences2 = Experience.all
  end

  # GET /universities/1
  # GET /universities/1.json
  def show

    @kennel = []
    3.times do
      @kennel << Experience.new
    end
    @experiences = @university.experiences.select(:experience).group(:experience).count.sort {|a,b| b[1]<=>a[1]}
    @experiences2 = @university.experiences
    @experiences2 = @experiences2.group_by_day(:created_at).count
    @experiences3 = @university.experiences.count
    @score = Score.new

  end

  # GET /universities/new
  def new
    @university = University.new
  end

  # GET /universities/1/edit
  def edit
  end

  # POST /universities
  # POST /universities.json
  def create
    @university = University.new(university_params)
    @university.user_id = current_user.id

    respond_to do |format|
      if @university.save
        format.html { redirect_to @university, notice: 'University was successfully created.' }
        format.json { render :show, status: :created, location: @university }
      else
        format.html { render :new }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /universities/1
  # PATCH/PUT /universities/1.json
  def update
    respond_to do |format|
      if @university.update(university_params)
        format.html { redirect_to @university, notice: 'University was successfully updated.' }
        format.json { render :show, status: :ok, location: @university }
      else
        format.html { render :edit }
        format.json { render json: @university.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /universities/1
  # DELETE /universities/1.json
  def destroy
    @university.destroy
    respond_to do |format|
      format.html { redirect_to universities_url, notice: 'University was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_university
      @university = University.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def university_params
      params.require(:university).permit(:user_id, :url, :name, :description, :image, :address, :latitude, :longitude, :facebook, :twitter, :linkedin, :country_code)
    end
end
