class ReferenceAttributesController < ApplicationController
  before_action :set_reference_attribute, only: [:show, :edit, :update, :destroy]

  # POST /reference_attributes
  # POST /reference_attributes.json
  def create
    @reference_attribute = ReferenceAttribute.new(reference_attribute_params)
    respond_to do |format|
      if @reference_attribute.save
        format.html { redirect_to edit_reference_path(@reference_attribute.reference_id), notice: "Attribute '#{@reference_attribute.name}' has been set to '#{@reference_attribute.value}'" }
        format.json { render action: 'show', status: :created, location: @reference_attribute }
      else
        format.html { redirect_to edit_reference_path(@reference_attribute.reference), alert: "Attribute '#{@reference_attribute.name}' was invalid!" }
        format.json { render json: @reference_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reference_attributes/1
  # PATCH/PUT /reference_attributes/1.json
  def update
    respond_to do |format|
      if @reference_attribute.update(reference_attribute_params)
        format.html { redirect_to edit_reference_path(@reference_attribute.reference), notice: "Attribute '#{@reference_attribute.name}' has been set to '#{@reference_attribute.value}'" }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_reference_path(@reference_attribute.reference), alert: "Attribute '#{@reference_attribute.name}' was invalid!" }
        format.json { render json: @reference_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reference_attributes/1
  # DELETE /reference_attributes/1.json
  def destroy
    attribute = @reference_attribute
    if(@reference_attribute.reference.can_remove_attribute?(@reference_attribute))
      @reference_attribute.destroy
      respond_to do |format|
        format.html { redirect_to edit_reference_path(attribute.reference), notice: "Attribute '#{attribute.name}' has been removed" }
        format.json { head :no_content }
      end
    else
      redirect_to references_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reference_attribute
      if !ReferenceAttribute.where(:id => params[:id]).first.nil?
        @reference_attribute = ReferenceAttribute.find(params[:id])
      else
        redirect_to references_path, notice: "Reference attribute not found or reference attribute has been removed"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_attribute_params
      params.require(:reference_attribute).permit(:reference_id, :name, :value)
    end
end
