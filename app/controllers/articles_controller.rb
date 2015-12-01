class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def create
		# for rendering the given params for the article || does work without ".inspect"
		# render plain: params[:article].inspect
		@article = Article.new(article_params)
		@article.save
		redirect_to articles_show(@article)
	end

	def show
		
	end

	private
	def article_params
		params.require(:article).permit(:title, :description)
	end

end