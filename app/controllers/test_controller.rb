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
    start_date="#{params[:year]}#{params[:month]}#{params[:day]}#{sprintf("%02d", params[:hour])}".to_datetime
    code=params[:code]

    open=nil
    high=0
    low=0
    close=0

    CSV.foreach("order_books.csv") do |row|
      next if row[0]=="time"

      if row[0].to_datetime >= start_date && code==row[1]
        if open.nil?
          open=row[2].to_i
          low=row[2].to_i
        end
        high=row[2].to_i if high < row[2].to_i
        low=row[2].to_i if low > row[2].to_i
        close=row[2].to_i
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
