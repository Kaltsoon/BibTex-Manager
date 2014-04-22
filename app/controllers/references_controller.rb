class ReferencesController < ApplicationController

  include BibtexGenerator
  include AcmFetcher
  include IdGenerator
  include BibtexParser

  before_action :set_reference, only: [:show, :edit, :update, :destroy]
  before_action :set_types, only: [:new, :create]

  def index
    @references = Reference.all
  end

  def show
  end

  def new
    @reference = Reference.new
    @attributes = {}
  end

  def edit
  end

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

  def destroy
    ref_name = @reference.name
    @reference.destroy
    respond_to do |format|
      format.html { redirect_to references_url, notice: "Reference '#{ref_name}' has been removed" }
      format.json { head :no_content }
    end
  end

  def generate_id_for_reference
      render json: { generated_id: generate_id(params[:attributes]) }
  end

  def plain_bibtex
    @references = Reference.includes(:reference_attributes).all
    @file_formated_bibtex = generate_bibtex_string(@references)
  end

  def download_bibtex
    references = Reference.includes(:reference_attributes).all
    send_bib(references)
  end

  def download_bibtex_single_reference
    reference = Reference.find(params[:id])
    send_bib([reference])
  end

  def download_filtered_references
    references = []
    if(params.has_key?(:references))
      params[:references].each do |key,val|
        references.push(Reference.find(key))
      end
    end
    send_bib(references)
  end

  def fetch_references_from_acm
    url = params[:url]
    @bibtex = fetch_bibtex_from_acm(url)
    render :acm_fetch_results
  end

  def save_references_from_acm
    raise params[:reference].inspect;
  end

  private

    def send_bib(references)
      if not references.empty?
        send_data(generate_bibtex_string(references).to_s, filename: "bibtex.bib")
      else
        send_data(" ", filename: "bibtex.bib")
      end
    end

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

    def set_reference
      if !Reference.where(:id => params[:id]).first.nil?
        @reference = Reference.find(params[:id])
      else
        redirect_to references_path, notice: "Reference not found or removed!"
      end
    end

    def reference_params
      params.require(:reference).permit(:ref_type, :name)
    end

end
