json.array!(@settings) do |setting|
  json.extract! setting, :id, :companie_id, :schedule_interval, :min_antecedence, :max_antecedence
  json.url setting_url(setting, format: :json)
end
