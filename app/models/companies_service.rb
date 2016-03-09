class CompaniesService < ActiveRecord::Base
  belongs_to :service
  belongs_to :company
  has_and_belongs_to_many :providers
  attr_accessor :service_name


  validates_presence_of :service
  validates_presence_of :company

  def service_name
    service.name if service_id
  end

end
