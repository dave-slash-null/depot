class CombineItemsInCart < ActiveRecord::Migration

  def up
  	# collapse multiple listings of the same item in a cart to a single listing
  	# with the appropriate quantity for that item
  	Cart.all.each do |cart|
  		sums = cart.line_items.group(:product_id).sum(:quantity)

  		sums.each do |product_id, quantity|
  			if quantity > 1
  				cart.line_items.where(product_id: product_id).delete_all

  				item = cart.line_items.build(product_id: product_id)
  				item.quantity = quantity
  				item.save!
  			end
  		end
  	end
  end

  def down
  	# break apart line items listed with a quantity greater than one, and
  	# instead create multiple listings for the line item to reflect the quantity
  	LineItem.where("quantity>1").each do |line_item|
  		line_item.quantity.times do
  			LineItem.create cart_id: line_item.cart_id,
  				product_id: line_item.product_id, quantity: 1
  		end

  		line_item.destroy
  	end
  end

end
