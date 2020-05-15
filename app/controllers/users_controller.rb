class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
  end

  def my_portfolio
    @tracked_stocks = current_user.stocks
    @user = current_user
  end

  def my_friends
    @user_friends = current_user.friends
  end

  def search_friends
    if params[:friend].present?
      @friends = User.search(params[:friend])
      # Show all searched for friends except the current user if the current_user is on of the results.
      @friends = current_user.except_current_user(@friends)
      if @friends
        respond_to do |format|
          format.js { render partial: "friends/friend_result" }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "User not available."
          format.js { render partial: "friends/friend_result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Enter a friend to proceed."
        format.js { render partial: "friends/friend_result" }
      end
    end
  end
end
