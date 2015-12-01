class ArticlesController < ApplicationController

	def new
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	def create
		# for rendering the given params for the article || does work without ".inspect"
		# render plain: params[:article].inspect

		# method article_params for accessing the given oarams
		@article = Article.new(article_params)

		if @article.save
			flash[:notice] = "Article was successfully created"
			# rake routes -> prefix article --> article_path
			redirect_to article_path(@article)
		else 
			render 'new'
		end
	end

	def update
		@article = Article.find(params[:id])
		# needs to be filled with the values of the form fields -> article_params
		if @article.update(article_params)
			flash[:notice] = "Article was successfully updated"
			redirect_to article_path(article_params)
		else 
			render 'edit'
		end
	end


	def show
		@article = Article.find(params[:id])
	end

	private
	def article_params
		params.require(:article).permit(:title, :description)
	end

end