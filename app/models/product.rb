class Product
  include Mongoid::Document

  validates_presence_of :name, :price, :installments, :image, :url

  field :name, type: String, default: ""
  field :price, type: Float, default: 0
  field :installments, type: Integer,, default: 1
  field :image, type: String, default: ""
  field :url, type: String, default: ""
  belongs_to :store
end
