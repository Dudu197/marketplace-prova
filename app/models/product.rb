class Product
  include Mongoid::Document
  field :name, type: String, required: true
  field :price, type: Float, required: true
  field :installments, type: Integer, required: true
  field :image, type: String, required: true
  field :url, type: String, required: true
  belongs_to :store
end
