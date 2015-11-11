json.array!(@companies) do |company|
  json.extract! company, :id, :user_id, :plan_id, :slogan, :logo, :website, :minipage_url
  json.url company_url(company, format: :json)
end
