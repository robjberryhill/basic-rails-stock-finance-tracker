class User < ApplicationRecord
  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  # Self referential relation also use standard has many syntax.
  # friend has Friendship with user. through the friendship table.
  has_many :friendships
  has_many :friends, through: :friendships

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

  def self.search(param)
    # strip the param being passed from the form of any spaces to the left or right
    param.strip!
    # create variable that will concatentate the matches.
    # But only uniq matches not multiple for each method.
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back

    to_send_back
  end

  def self.first_name_matches(param)
    # Match field first_name to passed in param from form.
    matches("first_name", param)
  end

  def self.last_name_matches(param)
    # Match field last_name to passed in param from form.
    matches("last_name", param)
  end

  def self.email_matches(param)
    # Match field email to passed in param from form.
    matches("email", param)
  end

  def self.matches(field_name, param)
    # Search the database for where a User field that is passed in field_name.
    # if the the field is like the param passed in..
    # Then this will return a record.
    # The % is a wildcard that will search for the param with in any string.
    # and not match exact string.
    where("#{field_name} like ?", "%#{param}%")
  end

  def except_current_user(users)
    # reject the user result if any of the users matches the current user id.
    users.reject { |user| user.id == id }
  end

  # Taking in the id of a friend.
  def not_friends_with?(id_of_friend)
    # look at the Users friends and if the id if the friend passed in does not exist then return true.
    !friends.where(id: id_of_friend).exists?
  end
end
