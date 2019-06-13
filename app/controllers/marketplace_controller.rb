class MarketplaceController < ApplicationController
	layout 'application'
	def index
		@products = Product.where(name: Regexp.new(/.*#{params[:busca]}.*/i)).order_by(created_at: :asc).page params[:page]
	end
end
