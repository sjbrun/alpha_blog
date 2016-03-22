class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Article was successfully created."
      redirect_to article_path(@article)
    else
      render 'new'  ## render new article template in case of failure for another try
    end
  end
  
  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'  ## render edit article template in case of failure for another try
    end      
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  private
  def article_params  # whitelist method
    params.require(:article).permit(:title, :description)
  end
end