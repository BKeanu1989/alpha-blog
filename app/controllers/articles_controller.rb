class ArticlesController < ApplicationController
	before_action :set_param_id, only: [:show, :destroy, :edit, :update]
	before_action :require_user, except: [:index, :show]
	before_action :require_article_owner, only: [:edit, :update, :destroy]

	def index

		# @article = Article.all
		@articles = Article.paginate(page: params[:page], per_page: 5)
	end

	def new
		@article = Article.new
	end

	def edit
		
	end

	def create
		# debugger
		# for rendering the given params for the article || does work without ".inspect"
		# render plain: params[:article].inspect

		# method article_params for accessing the given params
		@article = Article.new(article_params)
		@article.user = current_user
		# @article.user = User.first

		if @article.save
			flash[:success] = "Article was successfully created"
			# rake routes -> prefix article --> article_path
			redirect_to article_path(@article)
		else 
			render 'new'
		end
	end

	def update
		
		# needs to be filled with the values of the form fields -> article_params
		if @article.update(article_params)
			flash[:success] = "Article was successfully updated"
			redirect_to article_path(article_params)
		else 
			render 'edit'
		end
	end
	

	def show
		
	end

	def destroy
		
		@article.destroy
		flash[:danger] = "Article was successfully deleted"
		redirect_to articles_path
	end


	private
		def set_param_id
			@article = Article.find(params[:id])

		end
		def article_params
			params.require(:article).permit(:title, :description, category_ids: [])
		end

		def require_article_owner
			if current_user != @article.user and !current_user.admin?
				flash[:danger] = "You can only edit or delete your own articles"
				redirect_to root_path
			end
		end

end