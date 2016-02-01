json.array!(@appointments) do |appointment|
  json.extract! appointment, :id, :companie_id, :provider_service_id, :client_id, :title, :start, :end, :all_day, :obs, :price
  json.url appointment_url(appointment, format: :json)
end
