require 'test_helper'


class UserStoriesTest < ActionDispatch::IntegrationTest
	fixtures :products

	test "buying a product"
		LineItem.delete_all
		Order.delete_all
		south_of_heaven = products(:slayer)

		get "/"
		assert_response :success
		assert_template "index"

		xml_http_request :post, '/line_items', product_id: south_of_heaven.id
		assert_response :success

		cart = Cart.find(session[:cart_id])
		assert_equal 1, cart.line_items.size
		assert_equal south_of_heaven, cart.line_items[0].product

		get "/orders/new"
		assert_response :success
		assert_template "new"

		post_via_redirect "/orders",
							order: 	{ 	name: "Fuzzy Dunlop",
										address: "1 Wire Street",
										email: "McNulty@balt.pd",
										pay_type: "Check"	}
		assert_response :success
		assert_template "index"
		cart = Cart.find(session[:cart_id])
		assert_equal 0, cart.line_items.size

		orders = Order.all
		assert_equal 1, orders.size
		order = orders[0]

		assert_equal "Fuzzy Dunlop", 	order.name
		assert_equal "1 Wire Street",	order.address
		assert_equal "McNulty@balt.pd",	order.email
		assert_equal "Check",			order.pay_type

		assert_equal 1, order.line_items.size
		line_item = order.line_items[0]
		assert_equal south_of_heaven, line_item.product

		mail = ActionMailer::Base.deliveries.last
		assert_equal ["McNulty.balt.pd"], mail.to
		assert_equal "Dave <emailmaster@slayeralbums.com>", mail[:from].value
		assert_equal "Slayer Album Order Confirmation", mail.subject
  	end
end
