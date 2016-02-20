class CompaniesService < ActiveRecord::Base
  belongs_to :service
  belongs_to :company
  has_many :providers, through: :providers_services
  attr_accessor :service_name

  def service_name
    service.name if service_id
  end

end
