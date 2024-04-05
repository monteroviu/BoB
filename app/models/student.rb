class Student < ApplicationRecord
  belongs_to :group
  #agregada 08/02//
  has_many :invitations
  #validates :name, presence:true

  #after_destroy :actualizar_contador
  before_create :poner_nombre
  after_create :actualizar_contador
  after_create :send_invitation


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  #validates :email, presence: true, format: { with: VALID_EMAIL_REGEX, message: "No válido"}

  validates :email, presence: true, uniqueness: { scope: :group_id }, format: { with: VALID_EMAIL_REGEX, message: "No válido"}
  #validates_uniqueness_of :email, scope: :group_id

  def actualizar_contador
    if self.group.number_of_students == 0
    #  self.group.number_of_students =1
     self.group.update_attribute(:number_of_students,  1 )
    else
      #self.group.number_of_students= self.group.students.last.id
      self.group.update_attribute(:number_of_students,  self.group.number_of_students + 1)
    end
  #
  end

  def poner_nombre
    self.name = "Alumno" + (self.group.number_of_students + 1).to_s
  end
  private

  def send_invitation
    questionnaire = Questionnaire.find_by_code("01")
    group = self.group
    self.invitations.create(questionnaire_id: questionnaire.id, group_id: group.id, student_id: self.id)
    SurveyMailer.new_student(self.group.school, self.group, self, self.invitations.last).deliver_now
    puts " XXXXXXXXXXXXXXXXXXXXXXXXX Send invitation XXXXXXXXXXXXXXXXXXXXXXXXXXXXXx"
    puts self.group.school.name
    puts " XXXXXXXXXXXXXXXXXXXXXXXXX Send invitation XXXXXXXXXXXXXXXXXXXXXXXXXXXXXx"
  end

end
