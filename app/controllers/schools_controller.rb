class SchoolsController < ApplicationController
  before_action :set_school, only: %i[ show edit update destroy ]

  # GET /schools or /schools.json
  def index
    @schools = current_user.schools.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
  end

  # GET /schools/1 or /schools/1.json
  def show
    @groups = @school.groups.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
  end

  # GET /schools/new
  def new
    @school =current_user.schools.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools or /schools.json
  def create
    @school = current_user.schools.new(school_params)
    respond_to do |format|
      if @school.save
        format.html { redirect_to school_url(@school), notice: "Escuela creada correctamente." }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1 or /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to school_url(@school), notice: "La escuela ha sido actualizada correctamente." }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1 or /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url, notice: "La escuela ha sido borrada correctamente." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_school
      @school = current_user.schools.find(params[:id])
    end
    # Only allow a list of trusted parameters through.
    def school_params
      params.require(:school).permit(:name, :number_of_diagnoses, :generated)
    end
end
