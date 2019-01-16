class ArticlesController < ApplicationController
	before_action :correct_user,   only: [:edit, :update]

	def new
		@article = Article.new
	end

	def create
		article = Article.new(article_params)
		article.user_id = current_user.id
		if article.save
			redirect_to user_articles_path(current_user)
		else
			@article = Article.new(article_params)
			flash.now[:alert] = "本文・タイトルを入力してください"
			render :new
		end
	end

	def index
		@query = Article.ransack(params[:q])
		@articles = @query.result.page(params[:page]).per(40).order("created_at DESC")
	end

	def show
		@article = Article.find(params[:id])
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to article_path(@article)
		else
			render :edit
		end
	end

	def destroy
		article = Article.find(params[:id])
		article.destroy
		redirect_to user_articles_path(current_user)
	end

	def article_search
	    @query = Article.ransack(params[:q])
		@articles = @query.result.page(params[:page]).per(40).order("created_at DESC")
		render :index
	end

	def correct_user
      @article = Article.find(params[:id])
      redirect_to(root_path) unless @article.user == current_user
    end

	private

	def article_params
		params.require(:article).permit(:title, :text)
	end
end
