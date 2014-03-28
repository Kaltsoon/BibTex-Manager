class ReferenceAttributesController < ApplicationController
  before_action :set_reference_attribute, only: [:show, :edit, :update, :destroy]

  # GET /reference_attributes
  # GET /reference_attributes.json
  def index
    @reference_attributes = ReferenceAttribute.all
  end

  # GET /reference_attributes/1
  # GET /reference_attributes/1.json
  def show
  end

  # GET /reference_attributes/new
  def new
    @reference_attribute = ReferenceAttribute.new
  end

  # GET /reference_attributes/1/edit
  def edit
  end

  # POST /reference_attributes
  # POST /reference_attributes.json
  def create
    @reference_attribute = ReferenceAttribute.new(reference_attribute_params)
    respond_to do |format|
      if @reference_attribute.save
        format.html { redirect_to reference_path(@reference_attribute.reference_id), notice: "'#{@reference_attribute.name}' has been set to '#{@reference_attribute.value}'" }
        format.json { render action: 'show', status: :created, location: @reference_attribute }
      else
        format.html { render action: 'new' }
        format.json { render json: @reference_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reference_attributes/1
  # PATCH/PUT /reference_attributes/1.json
  def update
    respond_to do |format|
      if @reference_attribute.update(reference_attribute_params)
        format.html { redirect_to @reference_attribute, notice: 'Reference attribute was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reference_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reference_attributes/1
  # DELETE /reference_attributes/1.json
  def destroy
    @reference_attribute.destroy
    respond_to do |format|
      format.html { redirect_to reference_attributes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference_attribute
      @reference_attribute = ReferenceAttribute.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_attribute_params
      params.require(:reference_attribute).permit(:reference_id, :name, :value)
    end
end
