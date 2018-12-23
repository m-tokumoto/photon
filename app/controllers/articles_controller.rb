class ArticlesController < ApplicationController
	def new
		@article = Article.new
	end

	def create
		article = Article.new(article_params)
		article.user_id = current_user.id
		article.save
		redirect_to user_path(current_user)
	end

	def show
		@article = Article.find(params[:id])
	end

	private

	def article_params
		params.require(:article).permit(:title, :text)
	end
end
