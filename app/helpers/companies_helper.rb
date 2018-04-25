module CompaniesHelper

  def address_url(company)
    url = company.street.downcase + ' ' + company.city.downcase
    URI.encode(url, /\W/)
  end

  def address(company)
    company.street.titleize + ', ' + company.city.titleize
  end
end
