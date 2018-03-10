class GalleryController < ApplicationController
  before_action :set_item, :only => [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]
  
  def index
    @items = Item.all
    @items = @items.lookup_location(params[:location]) if params[:location].present?
    @items = @items.lookup_price(params[:price]) if params[:price].present?
    @items = @items.lookup_family(params[:family]) if params[:family].present?
    @items = @items.tagged_with(params[:tag]) if params[:tag].present?
    @items = @items.where(owner_id: User.find_by(user_name: params[:owner]).id) if params[:owner].present?
  end
  
  def my_listings
    @items = Item.where(:owner_id => current_user.id)
    render :index
  end
  
  def new
    @item = Item.new
    @images = @item.images.build
  end
  
  def create
    @item = Item.new(listing_params)
    @item.owner_id = current_user.id
    images = params[:images]
    
    if images.present?
      images['image'].each do |a|
        item_image = @item.images.new(:image => a)
      end
    end
    
    respond_to do |format|
      if @item.save
        format.html { redirect_to home_path, notice: 'Listing was successfully saved.' }
      else
        format.html { render :new }
      end
    end
    
  end
  
  private
  
  def set_item
    @item = Item.find(params[:id])
  end
  
  def listing_params
    params.require(:item).permit(:title, :description, :town_name, :price, :family_name, :tag_list, {:images => [:id, :item_id, :image]})
  end
  
end