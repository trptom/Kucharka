class ArticlesController < ApplicationController
  before_filter :user_rights_filter

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    # seznam komentaru pro clanek
    @comments = Comment.where(:article_id => @article.id)

    # entita na pridani noveho komentare
    @comment = Comment.new
    @comment.user = current_user
    @comment.article = @article
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    @article.user = current_user

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      @errors = @article.errors
      render action: "new"
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])

    if @article.update_attributes(params[:article])
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      @errors = @article.errors
      render action: "edit"
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to "/my_articles"
  end
end
