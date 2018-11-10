class RelationshipsController < ApplicationController
  before_action :logged_in_user
  attr_accessor :notifications

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def notifications
    @notifications = Relationship.where(follower_id: current_user.id, read: false)
  end
end