# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Product.delete_all

Product.create!(title: "Reign in Blood",
  description: "A landmark thrash metal album!",
  image_url: 'reign-in-blood.jpg',
  price: 15)
Product.create!(title: "South of Heaven",
  description: "Heavy, thrashing follow up to Reign in Blood.",
  image_url: 'south-of-heaven.png',
  price: 12)
Product.create!(title: "Hell Awaits",
  description: "An early entry in the Slayer collection.",
  image_url: 'hell-awaits.jpg',
  price: 7)