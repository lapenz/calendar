json.array!(@opening_hours) do |opening_hour|
  json.extract! opening_hour, :id, :companie_id, :provider_id, :weekday, :from, :to
  json.url opening_hour_url(opening_hour, format: :json)
end
