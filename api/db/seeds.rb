20.times do
  p = Product.new({
    :name => Faker::Lorem.words(1).join,
    :price => rand(200) + 1,
    :stock => rand(5) + 1,
    :description => Faker::Lorem.paragraph,
  })
  p.save!
  rand(5).times do
    c = p.comments.create!(:content => Faker::Lorem.sentence)
  end
  puts "Creating product #{p.name}..."
end