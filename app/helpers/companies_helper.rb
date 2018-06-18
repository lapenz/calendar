module CompaniesHelper

  def address_url(company)
    url = company.street.downcase unless company.street.blank?
    url += ' ' + company.city.downcase unless company.city.blank?
    URI.encode(url, /\W/) unless url.blank?
  end

  def address(company)
    text = company.street.titleize unless company.street.blank?
    text += ', ' + company.city.titleize unless company.city.blank?
  end
end
