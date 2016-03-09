class CompaniesServicesProviders < ActiveRecord::Base
  belongs_to :companies_service
  belongs_to :provider

  validates_presence_of :companies_service
  validates_presence_of :provider

end
