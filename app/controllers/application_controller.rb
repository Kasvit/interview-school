class ApplicationController < ActionController::Base
  helper_method :current_student

  def current_student
    @current_student ||= Student.find_by(id: session[:student_id])
  end
end
