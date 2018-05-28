class Company < ActiveRecord::Base
  has_many :companies_services
  belongs_to :user
  has_many :providers
  has_many :clients

  validates_uniqueness_of :minipage_url

  mount_uploader :logo, LogoUploader

end
