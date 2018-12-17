class Repeat < ApplicationRecord
  serialize :weekdays, Array
  validates_presence_of :typerepeat, :interval, :end
  validates_presence_of :weekdays, if: -> { self.typerepeat == 'weekly' }
  has_many :appointments
end
