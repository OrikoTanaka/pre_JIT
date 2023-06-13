class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user_id, only: [:index, :new, :create, :edit, :update]
  before_action :correct_user, only: [:index, :show, :edit, :update]
  before_action :set_article_id, only: [:show, :edit, :update, :destroy]
  UPDATE_ERROR_MSG = "記事の登録に失敗しました。やり直してください。"

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)
    if params[:article][:image].present?
      @article.image.attach(params[:article][:image])
    end

    if @article.save
     flash[:success] = "#{@article.title}を登録しました！"
      redirect_to user_article_url(current_user, @article)
    else
      render :new
    end
  end

  def edit
  end

  def update
    article = Article.find(params[:id])
    if article.update(article_params)
      flash[:success] = "#{article.title}の情報を更新しました。"
      redirect_to action: "index"
    else
      flash[:danger] = "更新に失敗しました。やり直してください。"
      render :edit
    end
  end

  def destroy
    @article.destroy
    redirect_to user_articles_path(current_user), notice: "『#{@article.title}』を削除しました。"
  end

  private

    def set_article_id
      @article = Article.find(params[:id])
    end

    def article_params
      params.require(:article).permit(:title, :content, :image)
    end

    def correct_user
      user = User.find(params[:user_id])
      redirect_to(new_user_session_path) unless user == current_user
    end
end
