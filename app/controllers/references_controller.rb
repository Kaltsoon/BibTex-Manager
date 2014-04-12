class ReferencesController < ApplicationController
  include BibtexGenerator

  before_action :set_reference, only: [:show, :edit, :update, :destroy]
  before_action :set_types, only: [:new, :create]

  # GET /references
  # GET /references.json
  def index
    @references = Reference.all
  end

  # GET /references/1
  # GET /references/1.json
  def show
  end

  # GET /references/new
  def new
    @reference = Reference.new
    @attributes = {}
  end

  # GET /references/1/edit
  def edit
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(reference_params)
    @attributes = params.require(:attribute)
    add_attributes(@reference, @attributes)
    if @reference.save
      redirect_to @reference, notice: "Reference was successfully created"
    else
      render action: "new"
    end
  end

  # PATCH/PUT /references/1
  # PATCH/PUT /references/1.json
  def update
    respond_to do |format|
      if @reference.update(params.require(:reference).permit(:name))
        format.html { redirect_to edit_reference_path(@reference), notice: "Reference id has been set to '#{@reference.name}'" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reference.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /references/1
  # DELETE /references/1.json
  def destroy
    ref_name = @reference.name
    @reference.destroy
    respond_to do |format|
      format.html { redirect_to references_url, notice: "Reference '#{ref_name}' has been removed" }
      format.json { head :no_content }
    end
  end

  def plain_bibtex
    @references = Reference.includes(:reference_attributes).all
    @file_formated_bibtex = generate_bibtex_string(@references)
  end

  def download_bibtex
    references = Reference.includes(:reference_attributes).all
    bib = generate_bibtex_string(references)
    send_data(bib.to_s, filename: "bibtex.bib")
  end

  def download_bibtex_single_reference
    reference = Reference.find(params[:id])
    bib = generate_bibtex_string([reference])
    send_data(bib.to_s, filename: "bibtex.bib")
  end

  def download_filtered_references
    id_hash = params[:references]
    references = []
    id_hash.each do |key,val|
      references.push(Reference.find(key))
    end
    if(not references.empty?)
      bib = generate_bibtex_string(references)
      send_data(bib.to_s, filename: "bibtex.bib")
    else
      send_data(" ", filename: "bibtex.bib")
    end
  end

  private

    def add_attributes(reference, attributes)
      attributes.each do |key, value|
          attribute = ReferenceAttribute.new(name: key, value: value)
          reference.reference_attributes.push(attribute) unless attribute.value.empty?
      end
    end

    def set_types
      @book_fields = BookReference.fields_to_render
      @article_fields = ArticleReference.fields_to_render
      @inproceedings_fields = InproceedingsReference.fields_to_render
      @ref_types = Reference.get_available_types
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_reference
      @reference = Reference.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reference_params
      params.require(:reference).permit(:ref_type, :name)
    end
end
