require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  def test_price
  	Product.new(title: 				"New Slayer album",
  							description: 	"It rocks.",
  							image_url: 		'slayer.jpg' )
  end

  test "product price is negative" do
  	product = test_price
  	product.price = -1
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]
  end

  test "product price is zero" do
  	product = test_price
  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]
  end

  test "product price is acceptable" do
  	product = test_price
  	product.price = 1
  	assert product.valid?
  end

  test "product price must be positive" do
  	product = Product.new(title: 				"New Slayer album",
  												description: 	"It rocks.",
  												image_url: 		'slayer.jpg' )

  	product.price = -1;
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 0
  	assert product.invalid?
  	assert_equal ["must be greater than or equal to 0.01"],
  		product.errors[:price]

  	product.price = 1
  	assert product.valid?
  end

  def insert_image_url(image_url)
  	Product.new(title: 				"New Slayer album",
  							description: 	"It rocks.",
  							price: 				1,
  							image_url: 		image_url )
  end
  	
  test "image url" do
  	acceptable = %w{ slayer.gif slayer.jpg slayer.png slaYer.JpG slaYER.GIF http://slayer.com/hanneman/lombardo/king/araya/bandpic.GIF }
  	unacceptable = %w{ hanneman.html araya.gif.erb king.xml lombardo/png }

  	acceptable.each do |name|
  		assert insert_image_url(name).valid?, "#{name} should be valid"
  	end

  	unacceptable.each do |name|
  		assert insert_image_url(name).invalid?, "#{name} should not be valid"
  	end

  end

  test "product is not valid without a unique title" do
    product = Product.new(title:        products(:one).title,
                          description:  "Matt parties",
                          price:        10,
                          image_url:    "party.jpg")

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

end
