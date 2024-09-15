require "digest"


class TestController < ApplicationController
  def fina_login
    render json: { token: Digest::SHA1.hexdigest("#{params[:username]}#{params[:password]}") }
  end

  def fina_flag
    p params[:flag]
  end

  def fina_candle
    p params
  end
end
