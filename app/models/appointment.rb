class Appointment < ActiveRecord::Base
  belongs_to :companies_service
  belongs_to :resource
  belongs_to :client, autosave: true

  accepts_nested_attributes_for :client

  validates_presence_of :companies_service
  validates_presence_of :resource
  validates_presence_of :client
  validates_presence_of :title
  validates_presence_of :start
  validates_presence_of :end

  validates :start, uniqueness: { scope: :resource_id }

  before_validation :set_title, on: [:create, :update]

  def resourceId
    self[:resource_id]
  end

  def duration
    self[:end].to_i - self[:start].to_i
  end

  def duration=(val)

  end

  def hashId
    ApplicationHelper.encrypt 'agendacard', self.id.to_s
  end

  private
  def set_title
    self.title = String.new
    self.title = self.client.name unless self.client.nil?
    self.title += ': ' + self.companies_service.service.name unless self.companies_service.nil?
    if self.title.blank?
      self.title = 'Agendamento'
    end
  end


end
