class StoreController < ApplicationController
	include CurrentCart
  skip_before_action :authorize
	before_action :set_cart
	
  def index
  	@products = Product.order(:price)
  	if session[:counter].nil?
  		session[:counter] = 0
  	end
  	session[:counter] += 1
   	@looks = session[:counter]
  end
end
