class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  VALID_CATEGORIES = [
    'Динамики',
    'Мультимедиа',
    'Вибро-шумоизоляция',
    'Приборы и датчики',
    'Кабель и комплектующие',
    'Усилители и процессоры',
    'Короба и подиумы'
  ]
  validates :category, inclusion: { in: VALID_CATEGORIES }
end
