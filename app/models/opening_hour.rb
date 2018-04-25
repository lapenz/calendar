class OpeningHour < ActiveRecord::Base
  serialize :weekdays
  scope :by_weekday, -> (weekday) { where('weekdays LIKE ?', "%'#{weekday}'%") }
  belongs_to :company


end
