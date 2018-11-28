class Company < ApplicationRecord
  has_many :companies_services
  belongs_to :user
  has_many :resources
  has_many :clients

  validates_uniqueness_of :minipage_url
  validates_presence_of :name

  mount_uploader :logo, LogoUploader

  before_validation :set_minipage_url, on: :create

  private
  def set_minipage_url
    self.minipage_url = I18n.transliterate(self.name.downcase.delete(' ')) + rand(10).to_s
  end

end
