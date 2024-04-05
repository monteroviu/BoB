class Group < ApplicationRecord
  belongs_to :school
  #agregadas 08/02/2022
  has_many :invitations

#  after_save :actualizar_estudiantes
  has_many  :students, dependent: :destroy
  has_attached_file :excel

  validates :name, presence:true, uniqueness: { scope: :school_id }

  validates_attachment_content_type :excel,  content_type: [

                                          'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
                                          'application/vnd.ms-excel',
                                          'application/xls',
                                          'application/xlsx',
                                          'application/octet-stream'
                                        ],
                                message: ' Sólo se permiten archivos en excel.'



  # def actualizar_estudiantes
  #   if !self.excel.nil?
  #     sheet = Roo::Spreadsheet.open(self.excel)
  #         (1..sheet.last_row).each do |row|
  #           record = sheet.row(row)
  #           self.students.new(email: record[0])
  #         end
  #   end
  #
  # end
end
