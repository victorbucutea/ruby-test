class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def new

  end

  def edit
    logger.debug "Invoked edit"
    @article = Article.find(params[:id])
    logger.debug @article
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def create
    # render plain: params[:article].inspect
    logger.debug "Creating article"
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    logger.debug "Invoked show"
    @articles = Article.all
    @article = Article.find(params[:id])
    logger.debug @article
  end

  def index
    @articles = Article.all
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end

end
