class StudentSchedulePdfGenerator
  def initialize(student)
    @student = student
  end

  def generate
    Prawn::Document.new do |pdf|
      pdf.text "#{@student.full_name}'s Schedule", size: 20, style: :bold
      pdf.move_down 10

      pdf.table(schedule_table_data, header: true, width: 500) do |table|
        table.row(0).font_style = :bold
        table.row(0).background_color = 'cccccc'
        table.cells.padding = 8
        table.position = :center
      end
    end
  end

  private

  def schedule_table_data
    [["Subject", "Start Time", "End Time", "Teacher", "Classroom"]] +
      @student.sections.map do |section|
        [
          section.subject_name.to_s,
          section.start_time.to_s,
          section.end_time.to_s,
          section.teacher_name.to_s,
          section.classroom_number.to_s
        ]
      end
  end
end
