class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @posts = pagy(Post.order(published_at: :desc))
  end

  def show
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.published_at = Time.current # 公開日を自動設定
    if @post.save
      redirect_to @post, notice: '投稿が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # 投稿者本人でなければ編集させない
    redirect_to root_path, alert: '権限がありません。' unless @post.user == current_user
  end

  def update
    if @post.user == current_user && @post.update(post_params)
      redirect_to @post, notice: '投稿が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.user == current_user
      @post.destroy
      redirect_to posts_url, notice: '投稿が削除されました。'
    else
      redirect_to root_path, alert: '権限がありません。'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content, :excerpt, :eyecatch)
  end
end
