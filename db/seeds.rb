# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# Создаем продукты для автозапчастей
autoparts = [
  { name: 'Фильтр масляный', description: 'Описание фильтра масляного', price: 25.0, category: 'Приборы и датчики' },
  { name: 'Фильтр воздушный', description: 'Описание фильтра воздушного', price: 15.0, category: 'Приборы и датчики' },
  { name: 'Фильтр топливный', description: 'Описание фильтра топливного', price: 20.0, category: 'Приборы и датчики' },
  { name: 'Тормозные колодки', description: 'Описание тормозных колодок', price: 50.0, category: 'Динамики' },
  { name: 'Тормозные диски', description: 'Описание тормозных дисков', price: 70.0, category: 'Динамики' },
  { name: 'Свечи зажигания', description: 'Описание свечей зажигания', price: 8.0, category: 'Кабель и комплектующие' },
  { name: 'Масло моторное', description: 'Описание моторного масла', price: 35.0, category: 'Кабель и комплектующие' },
  { name: 'Ремень генератора', description: 'Описание ремня генератора', price: 30.0, category: 'Короба и подиумы' },
  { name: 'Щетки стеклоочистителя', description: 'Описание щеток стеклоочистителя', price: 12.0, category: 'Короба и подиумы' },
  { name: 'Аккумуляторная батарея', description: 'Описание аккумуляторной батареи', price: 80.0, category: 'Усилители и процессоры' }
]

# Записываем данные в базу данных
autoparts.each do |autopart|
  Product.create!(autopart)
end

puts 'Autoparts seeded successfully!'
