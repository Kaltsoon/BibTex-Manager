Bibtex::Application.routes.draw do
  resources :reference_attributes, only: [:create, :update, :destroy]

  resources :references

  post "/generate_id_for_reference", to: "references#generate_id_for_reference"
  post "/fetch_references_from_acm", to: "references#fetch_references_from_acm"
  post "/download_filtered_references", to: "references#download_filtered_references"
  
  get "/plain_bibtex", to: "references#plain_bibtex"
  get "/download_all_references", to: "references#download_bibtex"
  get "/download_reference/:id", to: "references#download_bibtex_single_reference"
  get "/", to: "references#index"
 
end
