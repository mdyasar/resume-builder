class Project < ApplicationRecord
  belongs_to :experience

  def reject_experiences_create(experience)
    experience[:company].blank? or experience[:position].blank? or experience[:start_date].blank? or experience[:end_date].blank?
  end
end
