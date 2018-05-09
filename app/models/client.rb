class Client < ActiveRecord::Base
  has_many :appointments

  attr_accessor :full_validate

  validates_uniqueness_of :email

  validates_presence_of :name

  validates_presence_of :email, :phone, :if => 'full_validate.present?'


end
