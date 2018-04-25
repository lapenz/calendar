class Provider < ActiveRecord::Base
  has_and_belongs_to_many :companies_services
  belongs_to :company

  validates_presence_of :company
  validates_presence_of :name
end
