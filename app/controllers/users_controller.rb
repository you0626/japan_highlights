class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # ユーザー一覧を取得
  def index
    @users = User.all
    render json: @users
  end

  # ユーザー詳細を取得
  def show
    render json: @user
  end

  # 新規ユーザー作成
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # ユーザー情報を更新
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # ユーザー削除
  def destroy
    @user.destroy
    head :no_content
  end

  private

  # IDからユーザーを探す
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end

  # Strong Parameters（セキュリティ対策）
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end