json.array!(@resources) do |resource|
  json.extract! resource, :id, :company_id, :title, :name, :email, :phone
  json.url resource_url(resource, format: :json)
end
