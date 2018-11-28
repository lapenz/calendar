class OpeningHour < ApplicationRecord
  serialize :weekdays
  scope :by_weekday, -> (weekday) { where('weekdays LIKE ?', "%'#{weekday}'%") }
  belongs_to :company

  validates_presence_of :weekdays, :from, :to
end
