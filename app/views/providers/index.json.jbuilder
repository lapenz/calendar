json.array!(@providers) do |provider|
  json.extract! provider, :id, :companie_id, :name, :email, :phone
  json.url provider_url(provider, format: :json)
end
