class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item

	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :title, length: {minimum: 10, message: "is too short, minimum is 10 characters"}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: "must be a URL or GIF, JPG, or PNG image."
	}

	def self.latest
		Product.order(:updated_at).last
	end

	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line items present.')
			return false
		end
	end
end
