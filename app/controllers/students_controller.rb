class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def show
    @student = current_student
    @schedule = @student.sections
  end

  def download_schedule
    pdf = StudentSchedulePdfGenerator.new(current_student).generate
    send_data pdf.render, filename: "#{current_student.full_name}_schedule.pdf", type: 'application/pdf', disposition: 'inline'
  end
end
