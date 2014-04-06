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
    @bibtex = generate_bibtex_string([@reference]).gsub(/(?:\n\r?|\r\n?)/, '<br>')
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
    @reference.destroy
    respond_to do |format|
      format.html { redirect_to references_url }
      format.json { head :no_content }
    end
  end

  def plain_bibtex
    references = Reference.includes(:reference_attributes).all
    @plain_bibtex = generate_bibtex_string(references).gsub(/(?:\n\r?|\r\n?)/, '<br>')
  end

  def download_bibtex
    references = Reference.includes(:reference_attributes).all
    bib = generate_bibtex_string(references)
    send_data(bib.to_s, filename: "bitext.bib")
  end

  def download_bibtex_single_reference
    reference = Reference.find(params[:id])
    bib = generate_bibtex_string([reference])
    send_data(bib.to_s, filename: "bitext.bib")
  end

  private

    def add_attributes(reference, attributes)
      attributes.each do |key, value|
          attribute = ReferenceAttribute.new(name: key, value: value)
          reference.reference_attributes.push(attribute)
      end
    end

    def set_types
      @book_required_attributes = BookReference.get_required_attributes
      @article_required_attributes = ArticleReference.get_required_attributes
      @inproceedings_required_attributes = InproceedingsReference.get_required_attributes
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
