json.array!(@references) do |reference|
  json.extract! reference, :id, :type, :name
  json.url reference_url(reference, format: :json)
end
