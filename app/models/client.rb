class Client < ApplicationRecord
  has_many :appointments
  belongs_to :company

  attr_accessor :full_validate

  validates_presence_of :name

  validates_presence_of :email, :phone, if: -> { self.full_validate.present? }

  validates_uniqueness_of :email, scope: :company_id
end
