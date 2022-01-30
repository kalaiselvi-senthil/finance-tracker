class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    begin
      #client = IEX::Api::Client.new(publishable_token: 'PUBLISHABLE TOKEN HERE')
      client = IEX::Api::Client.new(publishable_token: 'pk_3a1fe74222ce4cae960003b8bb3a9f4b')
      looked_up_stock = client.quote(ticker_symbol)
      new(name: looked_up_stock.company_name,
          ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
    rescue Exception => e
      return nil
    end
  end

  #https://github.com/tyrauber/stock_quote
  #Add in gem file 
  #gem "stock_quote", '~> 3.0.0'
  # def self.new_from_lookup(ticker_symbol)
  #   begin
  #     looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
  #     price = looked_up_stock.close
  #     new(name: looked_up_stock.company_name,ticker: looked_up_stock.symbol, last_price: price)
  #   rescue Exception => e
  #     puts e
  #     return nil

  #   end
  # end
end
