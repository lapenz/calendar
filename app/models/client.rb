class Client < ActiveRecord::Base
  has_many :appointments
  validates_uniqueness_of :email

  validates_presence_of :email
  validates_presence_of :name
  validates_presence_of :phone

end
