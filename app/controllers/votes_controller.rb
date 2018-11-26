class VotesController < ApplicationController
  
  def create
    current_user.vote.create
    @user = User.find(params[:id])
    @user.increment!(:pop, 1)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

end
