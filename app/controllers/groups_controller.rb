class GroupsController < ApplicationController
  before_action :set_group, only: %i[ show edit update destroy upload_excel procesar_excel]

  # GET /groups or /groups.json
  def index

    @school = current_user.schools.find(params[:school_id])
    @groups = @school.groups

  end

  # GET /groups/1 or /groups/1.json
  def show
      @students= @group.students.paginate(:page => params[:page], :per_page => 5).order(created_at: :desc)
  end

  # GET /groups/new
  def new
    @school = current_user.schools.find(params[:school_id])
    @group = @school.groups.new
  end

  # GET /groups/1/edit
  def edit


  end

  # POST /groups or /groups.json
  def create
    @school = current_user.schools.find(params[:school_id])
    @group = @school.groups.new(group_params)


    respond_to do |format|
      if @group.save
      #  format.html { redirect_to group_url(@group), notice: "Group was successfully created." }
      format.html { redirect_to [@school, @group], notice: "La clase ha sido creada correctamente." }
      format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1 or /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)

      #  format.html { redirect_to [@school, @group], notice: "Group was successfully updated." }
      format.html { redirect_to [@school, @group], notice: "La clase ha sido modificada correctamente." }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1 or /groups/1.json
  def destroy
    @group.destroy

    respond_to do |format|
      format.html { redirect_to [@school], notice: "La clase ha sido eliminada correctamente." }
      format.json { head :no_content }
    end
  end

  def upload_excel
    puts "XXXXXXXXXXXXXXXXXXXX upload_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    p params.inspect
    puts "XXXXXXXXXXXXXXXXXXXX upload_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
  end

  def procesar_excel
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX procesar_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX procesar_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    archivo = params[:group]["excel"]
    puts archivo.inspect
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX procesar_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    @group.excel = archivo
    if @group.save
      sheet = Roo::Spreadsheet.open(@group.excel)
        if ! sheet.last_row.nil?
            (1..sheet.last_row).each do |row|
              record = sheet.row(row)
              if !record[0].nil?
                @group.students.new(email: record[0])

              else
                redirect_to [@school, @group], notice: "La clase no ha sido actualizada, error en el contenido del archivo: fila #{row}."
                return
              end
            end
          if @group.save
            redirect_to [@school, @group], notice: "La lista de alumnos ha sido actualizada exitosamente."
          else
            redirect_to [@school, @group], notice: "Error: La clase no ha sido actualizada correctamente. Se han detectado uno o más correos erróneos o duplicados."
          end
        else
            redirect_to [@school, @group], notice: "Error: La clase no ha sido actualizada, archivo vacío."
        end
    else
        redirect_to [@school, @group], notice: "Error: La clase no ha sido actualizada, sólo se admiten archivos tipo excel."
    end
    puts @group.inspect
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX procesar_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    puts "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX procesar_excel XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = current_user.groups.find(params[:id])
      @school = @group.school
    end

    # Only allow a list of trusted parameters through.
    def group_params
      params.require(:group).permit(:name, :school_id, :excel)
    end
end
