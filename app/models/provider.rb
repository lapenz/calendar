class Provider < ActiveRecord::Base
  belongs_to :user
  belongs_to :companie

  validates :user_id, presence: true
  validates :companie_id, presence: true
end
