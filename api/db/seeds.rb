20.times do
  p = Product.new({
    :name => Faker::Lorem.words(1).join,
    :price => rand(200) + 1,
    :stock => rand(5) + 1,
    :description => Faker::Lorem.paragraph,
  })
  p.save!
  puts "Creating product #{p.name}..."
end