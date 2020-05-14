class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def stock_already_tracked?(ticker_symbol)
    # Set the stock variable to the check database method in the Stock model.
    # If the stock is in the database then stock variable will have that stock object.
    stock = Stock.check_db(ticker_symbol)

    # Unless the stock variable exists then return false if it does not exist.
    return false unless stock

    # In User.stocks if the stock.id that was found ^ above exists in the User.stocks.
    # then this statment and entire method will return true.
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    # If the User.stocks are less than a 10 count then this method will return true.
    stocks.count < 10
  end

  def can_track_stock?(ticker_symbol)
    # if under_stock_limit? returns true and..
    # If stock_already_tracked? is not true..
    # Then this method will return true.
    # This will then allow you to add the stock to your portfolio in stock_result.html.erb.
    under_stock_limit? && !stock_already_tracked?(ticker_symbol)
  end

  def full_name
    # return first_name and last_name in a string if first_name or last_name exists.
    return "#{first_name} #{last_name}" if first_name || last_name

    # Else return this string.
    "Anonymous"
  end
end
