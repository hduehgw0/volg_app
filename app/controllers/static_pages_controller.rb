class StaticPagesController < ApplicationController
  def home
    # ホームページの内容を記述
    # 例: 最新の投稿を5件取得
    @latest_posts = Post.order(published_at: :desc).limit(5)
  end
end
