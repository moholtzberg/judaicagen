class Item < ActiveRecord::Base
  
  has_many :images
  has_many :taggings
  has_many :tags, through: :taggings
  belongs_to :owner, :class_name => "User"
  accepts_nested_attributes_for :images
  
  validates_presence_of :title
  validates_presence_of :family_name
  validates_presence_of :town_name
  validates_presence_of :price
  
  def self.get_by_locations(arr)
    query = ""
    arr.each do |v|
      if query == "" then
        query = "town_name like '" << v << "'"
      else
        query <<= " or town_name like '" << v << "'"
      end
    end
    where(query)
  end

  def self.get_by_families(arr)
    query = ""
    arr.each do |v|
      if query == "" then
        query = "family_name like '" << v << "'"
      else
        query <<= " or family_name like '" << v << "'"
      end
    end
    where(query)
  end
  
  def self.lookup_location(term)
    where("lower(town_name) like (?)", "%#{term.downcase}%")
  end
  
  def self.lookup_family(term)
    where("lower(family_name) like (?)", "%#{term.downcase}%")
  end

  def self.lookup_price(a, b)
    where("items.price >= #{a} and items.price <= #{b}")
  end
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).items
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").
      joins(:taggings).group("taggings.tag_id")
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
  
end