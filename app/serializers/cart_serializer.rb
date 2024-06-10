class CartSerializer
  include JSONAPI::Serializer
  attributes :id
  has_many :cart_items
end
