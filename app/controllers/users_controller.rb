class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers, :notifications]
  before_action :correct_user,   only: [:edit, :update, :notifications]
  def index
    @users = User.paginate(page: params[:page]).search(params[:search])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    @room_id = message_room_id(current_user, @user)
    @messages = Message.recent_in_room(@room_id)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to root_url
  end
  
  def block
    Block.create(blocking_id: current_user.id, blocked_id: params[:id] )
    flash[:success] = "ユーザーをブロックしました"
    redirect_to user_url(id: params[:id])
  end
  
  def reblock
    Block.find_by(blocking_id: current_user.id, blocked_id: params[:id]).destroy
    flash[:success] = "ユーザーをブロック解除しました"
    redirect_to blocklist_path
  end
  
  def blocklist
    @blocklist = current_user.blocker
  end
  
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
  
  def notifications
    @notifications = Relationship.where(followed_id: current_user.id, read: false)
  end
  
  def message_room_id(first_user, second_user)
    first_id = first_user.id.to_i
    second_id = second_user.id.to_i
    if first_id < second_id
      "#{first_user.id}-#{second_user.id}"
    else
      "#{second_user.id}-#{first_user.id}"
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :intro, :password,
                                   :password_confirmation, :image, :pop)
    end
end
