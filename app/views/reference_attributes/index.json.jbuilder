json.array!(@reference_attributes) do |reference_attribute|
  json.extract! reference_attribute, :id, :reference_id, :name, :value
  json.url reference_attribute_url(reference_attribute, format: :json)
end
