class SessionsController < ApplicationController
  def login_as
    student = Student.find(params[:id])
    session[:student_id] = student.id

    flash[:notice] = "Logged in as #{student.full_name}"
    redirect_to root_path
  end
end
