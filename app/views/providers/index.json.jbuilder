json.array!(@providers) do |provider|
  json.extract! provider, :id, :company_id, :title, :name, :email, :phone
  json.url provider_url(provider, format: :json)
end
