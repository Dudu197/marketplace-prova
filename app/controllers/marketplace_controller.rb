class MarketplaceController < ApplicationController
	layout 'application'
	def index
		@products = Product.order_by(created_at: :asc).page params[:page]
	end
end
