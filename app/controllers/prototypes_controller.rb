class PrototypesController < ApplicationController
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def index#一覧表示(トップページ)
    @prototypes = Prototype.includes(:user)#userモデルの情報全てを指定
  end

  def new#生成
    @prototype = Prototype.new
  end

  def show#詳細ページ
    @comment = Comment.new
    @comments = @prototype.comments
  end

  def edit#編集ページ
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end

  def create#保存
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to '/' # トップページに移動
    else
      # 保存に失敗した場合の処理を記述
      puts @prototype.errors.full_messages
      render :new #新規登録ページを再表示
    end
  end

  private

  def prototype_params#user_idに対して関連付けして保存
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype#指定のIDのデータベースを取得
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confirmation
    redirect_to root_path unless current_user == @prototype.user
  end

end
