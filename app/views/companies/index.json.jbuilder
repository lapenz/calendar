json.array!(@companies) do |company|
  json.extract! company, :id, :user_id, :plan_id, :setting_id, :slogan, :logo, :website, :minipage_url, :name, :phone, :street, :city
  json.url company_url(company, format: :json)
end
