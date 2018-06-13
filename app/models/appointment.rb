class Appointment < ActiveRecord::Base
  belongs_to :companies_service
  belongs_to :provider
  belongs_to :client, autosave: true

  accepts_nested_attributes_for :client

  validates_presence_of :companies_service
  validates_presence_of :provider
  validates_presence_of :client
  validates_presence_of :title
  validates_presence_of :start
  validates_presence_of :end

  validates :start, uniqueness: { scope: :provider_id }

  def resourceId
    self[:provider_id]
  end

  def duration
    self[:end].to_i - self[:start].to_i
  end

  def duration=(val)

  end

  def hashId
    ApplicationHelper.encrypt 'agendacard', self.id.to_s
  end


end
