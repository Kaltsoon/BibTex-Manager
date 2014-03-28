require "spec_helper"

describe ReferenceAttributesController do
  describe "routing" do

    it "routes to #index" do
      get("/reference_attributes").should route_to("reference_attributes#index")
    end

    it "routes to #new" do
      get("/reference_attributes/new").should route_to("reference_attributes#new")
    end

    it "routes to #show" do
      get("/reference_attributes/1").should route_to("reference_attributes#show", :id => "1")
    end

    it "routes to #edit" do
      get("/reference_attributes/1/edit").should route_to("reference_attributes#edit", :id => "1")
    end

    it "routes to #create" do
      post("/reference_attributes").should route_to("reference_attributes#create")
    end

    it "routes to #update" do
      put("/reference_attributes/1").should route_to("reference_attributes#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/reference_attributes/1").should route_to("reference_attributes#destroy", :id => "1")
    end

  end
end
