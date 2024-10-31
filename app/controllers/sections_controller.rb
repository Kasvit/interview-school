class SectionsController < ApplicationController
  before_action :set_section, only: %i[ show edit update destroy enroll withdraw ]

  # GET /sections or /sections.json
  def index
    @sections = Section.all
  end

  # GET /sections/1 or /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
  end

  # POST /sections or /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1 or /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: "Section was successfully updated." }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1 or /sections/1.json
  def destroy
    @section.destroy

    respond_to do |format|
      format.html { redirect_to sections_path, status: :see_other, notice: "Section was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def enroll
    student_section = StudentSection.new(student: current_student, section: @section)

    if student_section.save
      flash[:notice] = "Successfully enrolled in the section."
      redirect_to student_path(current_student)
    else
      flash[:alert] = "Enrollment failed: #{student_section.errors.full_messages.to_sentence}"
      redirect_to section_path(@section)
    end
  end

  def withdraw
    if current_student.sections.include?(@section)
      current_student.sections.delete(@section)
      flash[:notice] = "Successfully withdrew from the section."
    else
      flash[:alert] = "You're not enrolled in this section."
    end
    redirect_to @section
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def section_params
      params.require(:section).permit(:teacher_id, :subject_id, :classroom_id, :start_time, :end_time, days_of_week: [])
    end
end
