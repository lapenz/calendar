class Companie < ActiveRecord::Base
  belongs_to :user
  belongs_to :plan

  validates :user_id, presence: true
  validates :plan_id, presence: true
end
