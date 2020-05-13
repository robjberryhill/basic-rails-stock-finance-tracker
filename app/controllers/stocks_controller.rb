class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      # render json: @stock
      # if variable is not nil then..
      if @stock
        # Choose how to respond with the data.
        # In this case it is JS.
        respond_to do |format|
          # This will expect a js.erb file at this location.
          # This will render the partial without reloading the page.
          format.js { render partial: "users/stock_result" }
        end
        # with no js you will need to load a page.
        # render view
        # render "users/my_portfolio"

        # else if it is nil then..
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a valid symbol to search."
          format.js { render partial: "users/stock_result" }
        end

        # If not using js
        # Send message and reload page.
        # redirect_to my_portfolio_path
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a symbol to search."
        format.js { render partial: "users/stock_result" }
      end

      # If not using JS.
      # flash[:alert] = "Please enter a symbol to search."
      # redirect_to my_portfolio_path
    end
  end
end
