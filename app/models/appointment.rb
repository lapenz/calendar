class Appointment < ActiveRecord::Base
  belongs_to :companies_service
  belongs_to :provider
  belongs_to :client, autosave: true

  validates_presence_of :companies_service
  validates_presence_of :provider
  validates_presence_of :client
  validates_presence_of :title
  validates_presence_of :start
  validates_presence_of :end
end
