class UsersController < ApplicationController
  def index
    @pagy, @users = pagy(User.all)
  end

  def show
    @user = User.find(params[:id])
    @pagy, @posts = pagy(@user.posts.order(published_at: :desc))
  end
end
