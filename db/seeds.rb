# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


f1 = Fragrance.find_or_create_by(name:'Smokey', description: 'Smokey scent', category: 'basic', image_url: ""  )
f2 = Fragrance.find_or_create_by(name:'Fresh', description: 'Fresh scent', category: 'basic', image_url: ""  )
f3 = Fragrance.find_or_create_by(name:'Floral', description: 'Floral scent', category: 'basic', image_url: ""  )
f4 = Fragrance.find_or_create_by(name:'Herbaceous', description: 'Herbacous scent', category: 'basic', image_url: ""  )
f5 = Fragrance.find_or_create_by(name:'Citrus', description: 'Citrus scent', category: 'basic', image_url: ""  )
f6 = Fragrance.find_or_create_by(name:'Woody', description: 'Woody scent', category: 'basic', image_url: ""  )


6.times { |n| Candle.find_or_create_by(fragrance_id: n+1)}