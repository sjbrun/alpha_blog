class ArticlesController < ApplicationController
  ## run "set_article" method before specified methods
  before_action :set_article, only: [:edit,:update,:show,:destroy]
  
  def index
    @articles = Article.all
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    
  end
  
  def create
    ## debugger
    @article = Article.new(article_params)
    @article.user = User.first  ## hard-coded first user to make all articles (temporarily)
    if @article.save
      flash[:success] = "Article was successfully created."
      redirect_to article_path(@article)
    else
      render 'new'  ## render new article template in case of failure for another try
    end
  end
  
  def update
    if @article.update(article_params)
      flash[:success] = "Article was successfully updated."
      redirect_to article_path(@article)
    else
      render 'edit'  ## render edit article template in case of failure for another try
    end      
  end
  
  def show
    
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Article was successfully deleted."
    redirect_to articles_path
  end
  
  private
    def set_article  ## create private method to reuse
      @article = Article.find(params[:id])
    end
    def article_params  # whitelist method
      params.require(:article).permit(:title, :description)
    end
end