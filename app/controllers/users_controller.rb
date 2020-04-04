class UsersController < ApplicationController
  before_action :login_check, only: [:index, :new, :show, :edit, :update, :destroy,:following, :followers]
	before_action :baria_user, only: [:update, :edit, :destroy]

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def index
  	@users = User.all#一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
  end
  def show
      @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
      @user = User.find(params[:id])
      @books = @user.books.page(params[:page]).reverse_order
  end
  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user.id), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end

  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
  def login_check
    unless user_signed_in?
    flash[:alert] = "ログインしてください"
    redirect_to "/users/sign_in"
    end
  end
  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
end
