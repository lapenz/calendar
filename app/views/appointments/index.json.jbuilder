json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :companies_service_id, :company_id, :resource_id, :resourceId, :client_id, :title, :start, :end, :allday, :obs, :price
  json.url appointment_url(appointment, format: :json)
end
