class Resource < ApplicationRecord
  has_and_belongs_to_many :companies_services
  belongs_to :company

  validates_presence_of :company
  validates_presence_of :name

  def title
    self[:name]
  end
end
