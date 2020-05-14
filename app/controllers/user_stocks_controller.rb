class UserStocksController < ApplicationController
  def create
    # Set the stock to the Stock according to the ticker being passed in in the params.
    # Use the check_db method in the Stock model to check the database for the stock.
    stock = Stock.check_db(params[:ticker])
    # If no stock is found in the db then look up the stock in the API with new_lookup
    if stock.blank?
      # Set stock to the Stock found at the API by the ticker passed in the params.
      stock = Stock.new_lookup(params[:ticker])
      stock.save
    end
    # create the UserStock for the current user with the stock found.
    @user_stock = UserStock.create(user: current_user, stock: stock)
    # Send message and reload page.
    flash[:notice] = "Stock #{stock.name} was added to your portfolio."
    redirect_to my_portfolio_path
  end

  def destroy
    # Set stock to the Stock that is being passed in the params by the id.
    # We are not removing the entire stock because multiple users may be using it.
    # We are removing the stock from the portfolio of the current user.
    stock = Stock.find(params[:id])
    # user_id and stock_id are from the UserStock table we need to search for both to find the right row for the user.
    # Set user_stock to the row where the current user id and the stock id are in the same place.
    user_stock = UserStock.where(user_id: current_user.id, stock_id: stock.id).first
    # Once the user_stock is set to the appropriate row the destroy it.
    user_stock.destroy
    # Send message then reload the page.
    flash[:notice] = "#{stock.ticker} was removed from portfolio."
    redirect_to my_portfolio_path
  end
end
