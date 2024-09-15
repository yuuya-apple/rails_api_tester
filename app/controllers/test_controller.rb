require "digest"


class TestController < ApplicationController
  def fina_login
    render json: { token: Digest::SHA1.hexdigest("#{params[:username]}#{params[:password]}") }
  end
end
