class ImportController < ApplicationController
	layout 'import'
	before_action :authenticate_store!
	protect_from_forgery except: ['import']

	def index
		@store = current_store
		@products = @store.products
	end

	def import
		current_store.import_products(params[:de], params[:ate])
		render json: {status: "ok"}
	end
end
