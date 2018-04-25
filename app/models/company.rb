class Company < ActiveRecord::Base
  has_many :companies_services
  belongs_to :user


end
