class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  require 'carrierwave/orm/activerecord'
  # GET /items
  # GET /items.json
  def index
    @items = Item.all
    @items = @items.lookup_location(params[:location]) if params[:location].present?
    @items = @items.lookup_price(params[:price]) if params[:price].present?
    @items = @items.lookup_family(params[:family]) if params[:family].present?
    @items = @items.tagged_with(params[:tag]) if params[:tag].present?
    @items = @items.where(owner_id: User.find_by(user_name: params[:owner]).id) if params[:owner].present?
  end

  def my_listing
    @items = Item.where(:owner_id => current_user.id)
    render :index
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @images = @item.images.build
  end

  # GET /items/1/edit
  def edit
    owner = User.find(current_user.id)
    @item = Item.where(owner: owner).find(params[:id])
    rescue ActiveRecord::RecordNotFound  
      redirect_to :controller => "items", :action => "index"
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    @item.owner_id = current_user.id
    images = params[:images]
    
    if images.present?
      images['image'].each do |a|
        item_image = @item.images.new(:image => a)
      end
    end
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:title, :description, :town_name, :family_name, :tag_list, :price, :images => [:id, :item_id, :image])
    end
end
