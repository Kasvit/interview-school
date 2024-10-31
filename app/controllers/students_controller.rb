class StudentsController < ApplicationController

  def index
    @students = Student.all
  end

  def show
    @student = current_student
    @schedule = @student.sections
  end
end
