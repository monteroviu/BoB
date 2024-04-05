class Invitation < ApplicationRecord
  belongs_to :questionnaire
  belongs_to :group
  belongs_to :student

  before_create :set_token


  def set_token
    self.token="XXXX111"
  end

end
