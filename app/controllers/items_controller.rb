class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    if params[:tag_list].present?
      tags = params[:tag_list].split(' ')
      search = tags.map{ |t| t.remove('+') if t.include?('+') }.compact
      remove = tags.map{ |t| t.remove('-') if t.include?('-') }.compact

      @items = remove.present? ? Item.paginate(:page => params[:page]).tagged_with(search, :any => true,:wild => true).tagged_with(remove, :exclude => true,:wild => true) : Item.paginate(:page => params[:page]).tagged_with(search, :any => true,:wild => true) 
      else
      @items = Item.all
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    if @item.save
      render :show, status: :created#, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    if @item.update(item_params)
      render :show, status: :ok, location: @item
    else
      render json: @item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name,:picture,:tag_list)
    end
end
