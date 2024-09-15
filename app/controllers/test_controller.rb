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
    start_date="#{params[:year]}#{sprintf("%02d", params[:month])}#{sprintf("%02d", params[:day])}#{sprintf("%02d", params[:hour])}+0900'".to_datetime
    end_date=start_date+ Rational(1, 24)
    range = start_date...end_date

    code=params[:code]

    open=nil
    high=0
    low=0
    close=0


    CSV.foreach("order_books.csv") do |row|
      next if row[0]=="time"

      if range.cover?(row[0].to_datetime) && code==row[1]
        if open.nil?
          open=row[2].to_i
          low=row[2].to_i
        end
        high=row[2].to_i if high < row[2].to_i
        low=row[2].to_i if low > row[2].to_i
        close=row[2].to_i
      end
    end

    render json: { "open": open, "high": high, "low": low, "close": close }
  end

  def test_test
    a=0
    CSV.foreach("order_books.csv") do |row|
      a= row
    end
    render json: { token: a[0].to_datetime, bool: a[0].to_datetime<"2021122214".to_datetime }
  end
end
