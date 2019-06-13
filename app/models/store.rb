require 'net/http'
class Store
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  API_URL = "/api/catalog_system/pub/products/search"

  validates_presence_of :website, :logo

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  # Sotre fields
  field :name, type: String, default: ""
  field :website, type: String, default: ""
  field :logo, type: String, default: ""

  has_many :products


  def import_products(from=0, to=49)
    uri = URI.parse("#{website}#{API_URL}?_from=#{from}&_to=#{to}")
    content = Net::HTTP.get(uri)
    json_value = JSON.parse(content)
    item = json_value.first
    json_value.each do |item|
      installments = item['items'].first['sellers'].first['commertialOffer']['Installments']
      product = Product.new
      product.name = item['productTitle']
      product.price = installments.max_by{|k| k['Value'] }['Value']
      product.installments = installments.max_by{|k| k['NumberOfInstallments'] }['NumberOfInstallments']
      product.image = item['items'].first['images'].first['imageUrl']
      product.url = item['link']
      products << product
    end
    return save
  end


  ## Trackable
  # field :sign_in_count,      type: Integer, default: 0
  # field :current_sign_in_at, type: Time
  # field :last_sign_in_at,    type: Time
  # field :current_sign_in_ip, type: String
  # field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
end
