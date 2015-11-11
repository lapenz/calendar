class Setting < ActiveRecord::Base
  belongs_to :companie

  validates :companie_id, presence: true
  validates :schedule_interval, presence: true
  validates :min_antecedence, presence: true
  validates :max_antecedence, presence: true
end
