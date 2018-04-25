json.array!(@companies_services) do |companies_service|
  json.extract! companies_service, :id, :company_id, :service_id, :duration, :description, :price
  json.url companies_service_url(companies_service, format: :json)
end
