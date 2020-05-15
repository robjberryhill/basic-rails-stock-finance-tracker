class FriendshipsController < ApplicationController
  def create
    # Setting friend to the User that is the friend being passed in params.
    friend = User.find(params[:friend])
    # The build will also create a record according to the params passed in.
    current_user.friendships.build(friend_id: friend.id)
    if current_user.save
      flash[:alert] = "Added Friend"
    else
      flash[:notice] = "There was something wrong with the request."
    end
    redirect_to friends_path
  end

  def destroy
    friendship = current_user.friendships.where(friend_id: params[:id]).first
    friendship.destroy
    flash[:notice] = "Removed."
    redirect_to friends_path
  end
end
