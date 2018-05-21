class Company < ActiveRecord::Base
  has_many :companies_services
  belongs_to :user
  has_many :providers

  validates_uniqueness_of :minipage_url


end
