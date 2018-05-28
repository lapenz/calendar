class Client < ActiveRecord::Base
  has_many :appointments
  belongs_to :company

  attr_accessor :full_validate

  validates :email, uniqueness: { scope: :company_id }

  validates_presence_of :name

  validates_presence_of :email, :phone, :if => 'full_validate.present?'


end
