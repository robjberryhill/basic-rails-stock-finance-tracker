class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex_client[:sandbox_api_key],
      endpoint: "https://sandbox.iexapis.com/v1",
    )
    # client.price(ticker_symbol)

    # Begin the API call..
    begin
      # If API is success then return the following object.
      new(ticker: ticker_symbol,
          name: client.company(ticker_symbol).company_name,
          last_price: client.price(ticker_symbol))

    # If an exception is returned the handle it.
    rescue => exception
      return nil
    end
  end
end
