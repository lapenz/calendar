class Appointment < ApplicationRecord
  belongs_to :companies_service
  belongs_to :resource
  belongs_to :client, autosave: true

  accepts_nested_attributes_for :client

  validates_presence_of :companies_service_id
  validates_presence_of :resource_id
  validates_presence_of :start
  validates_presence_of :end

  validates :start, uniqueness: { scope: :resource_id }

  def resourceId
    self[:resource_id]
  end

  def duration
    self[:end].to_i - self[:start].to_i
  end

  def duration=(val)

  end

  def hashId
    ApplicationHelper.encrypt 'ajweidi234idfh35', self.id.to_s
  end

  def title
    title = String.new
    title = self.client.nil? ? 'Anônimo' : self.client.name
    title += ': ' + self.companies_service.service.name unless self.companies_service.nil?

  end


end
