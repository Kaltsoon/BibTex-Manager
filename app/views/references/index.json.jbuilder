json.array!(@references) do |reference|
  json.extract! reference, :id, :ref_type, :name, :reference_attributes, :get_bibtex
  json.url reference_url(reference, format: :json)
end
