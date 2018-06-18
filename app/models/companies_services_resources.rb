class CompaniesServicesResources < ActiveRecord::Base
  belongs_to :companies_service
  belongs_to :resource

  validates_presence_of :companies_service
  validates_presence_of :resource

end
