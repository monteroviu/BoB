class SurveyMailer < ApplicationMailer
  def new_student(school,group,student,invitation)
    @student = student
    @group=group
    @school=school
    @invitation=invitation
    mail(to: student.email, subject: "Cuestionario B0B")
  end
end
