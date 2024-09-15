require "digest"
require "csv"


class TestController < ApplicationController
  def fina_login
    render json: { token: Digest::SHA1.hexdigest("#{params[:username]}#{params[:password]}") }
  end

  def fina_flag
    p params[:flag]
  end

  def fina_candle
    start_date=params[:year]+params[:month]+params[:day]+params[:hour].to_datetime
    code=params[:code]


    open=nil
    high=0
    low=0
    close=0


    CSV.foreach("order_books.csv") do |row|
      if row[0].to_datetime >= start_date && code==row[1]
        if open.nil?
          open=row[2]
          low=row[2]
        end
        high=row[2] if high<row[2]
        low=row[2] if low > row[2]
        close=row[2]
      end
    end

    render json: { open: open, high: high, low: low, close: close }
  end

  def test_test
    a=0
    CSV.foreach("order_books.csv") do |row|
      a= row
    end
    render json: { token: a[0].to_datetime, bool: a[0].to_datetime<"2021122214".to_datetime }
  end
end
