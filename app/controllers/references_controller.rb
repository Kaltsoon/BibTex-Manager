class ReferencesController < ApplicationController
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
  end

  # GET /references/1/edit
  def edit
  end

  # POST /references
  # POST /references.json
  def create
    @reference = Reference.new(reference_params)
    if @reference.save
      @attributes=params.require(:attribute)
      @attributes.each do |key, value|
        ReferenceAttribute.create(reference_id: @reference.id, name: key, value: value)
      end
      redirect_to @reference, notice: "Reference was successfully created"
    else
      render action: "new"
    end
  end

  # PATCH/PUT /references/1
  # PATCH/PUT /references/1.json
  def update
    respond_to do |format|
      if @reference.update(reference_params)
        format.html { redirect_to @reference, notice: 'Reference was successfully updated.' }
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

  private

    def set_types
      @book_required_attributes = BookReference.required_attributes
      @article_required_attributes = ArticleReference.required_attributes
      @inproceedings_required_attributes = InproceedingsReference.required_attributes
      @ref_types = ["book", "inproceedings", "article"]
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
