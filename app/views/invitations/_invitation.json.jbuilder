json.extract! invitation, :id, :Questionnaire_id, :Group_id, :Student_id, :created_at, :updated_at
json.url invitation_url(invitation, format: :json)
