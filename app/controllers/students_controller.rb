class StudentsController < ApplicationController
  before_action :set_student, only: %i[ show edit update destroy ]

  # GET /students or /students.json
  def index
    @school = current_user.schools.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @students =@group.students
  end

  # GET /students/1 or /students/1.json
  def show
    @school = current_user.schools.find(params[:school_id])

  end

  # GET /students/new
  def new
    @school = current_user.schools.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @student=@group.students.new

  end

  # GET /students/1/edit
  def edit
    @school = current_user.schools.find(params[:school_id])
  end

  # POST /students or /students.json
  def create
    @school = current_user.schools.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @student = @group.students.new(student_params)
    #@invitation= @student.invitations.new(1, @group.id, @student.id)
  #  @invitation= @student.invitations.new()

puts "=================================invitation ==============================================="
#puts @invitation
puts "================================================================================"
puts "================================================================================"
puts "==========================voy a salvar==========================================="
    respond_to do |format|
      if @student.save
        format.html { redirect_to [@school, @group, @student], notice: "El estudiante ha sido creado correctamente." }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1 or /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to student_url(@student), notice: "Student was successfully updated." }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1 or /students/1.json
  def destroy
    @student.destroy

    respond_to do |format|
      format.html { redirect_to [@school, @group], notice: "Se ha borrado correctamente al estudiante." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
    @school = current_user.schools.find(params[:school_id])
    @group = @school.groups.find(params[:group_id])
    @student = @group.students.find(params[:id])
    #  @student=current_user.schools.groups.students.find(params[:id])
    #  @group =@student.group
    #  @school=@group.student
    end

    # Only allow a list of trusted parameters through.
    def student_params
      params.require(:student).permit(:name, :email, :status, :group_id)
    end
end
