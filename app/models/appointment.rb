class Appointment < ApplicationRecord
  belongs_to :companies_service, required: false
  belongs_to :resource, required: false
  belongs_to :client, autosave: true
  belongs_to :company
  belongs_to :repeat, required: false

  accepts_nested_attributes_for :client, :repeat

  after_initialize :set_defaults

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
    title.concat ': ' + self.companies_service.service.name unless self.companies_service.nil?
    return title
  end

  def set_defaults
    self.remindertime = 7200 if self.new_record?
  end


end
